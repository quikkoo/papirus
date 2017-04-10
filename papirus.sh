#!/bin/sh

if [ "$(id -u)" -ne 0 ]
then
  echo "Please run as root!"
  exit 1
fi

usage() {
  echo "$1"
  echo "Usage: ./papirus.sh <tool> <version>"
  exit 1
}

if [ -z $1 ]
then
  usage "missing tool"
fi

if [ -z $2 ]
then
  usage "missing version"
fi

dependencies() {
  for CMD in "$@"
  do
    type $CMD >/dev/null 2>&1
    if [ $? -eq 0 ]
    then
      echo "cheking $CMD: ok"
    else
      echo "cheking $CMD: no"
      exit 1
    fi
  done
}

dependencies curl

set -e

TOOL=$1
VERSION=$2

TARGET=${TARGET:-"https://raw.githubusercontent.com/quikkoo/papirus/master"}

echo "fetching $TOOL version $VERSION"
curl -sSL "$TARGET/$TOOL.sh" | sh -s "$VERSION"

#!/bin/sh

if [ "$(id -u)" -ne 0 ]
then
  echo "please run as root!"
  exit 1
fi

if [ -z $1 ]
then
  echo "missing version"
  exit 1
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

dependencies curl java

set -e

   LEININGEN_HOME="/opt/leiningen"
LEININGEN_VERSION="$1"
LEININGEN_PACKAGE="/tmp/lein"
LEININGEN_TARBALL="https://raw.githubusercontent.com/technomancy/leiningen/$LEININGEN_VERSION/bin/lein"

curl -sSL $LEININGEN_TARBALL -o $LEININGEN_PACKAGE
chmod +x $LEININGEN_PACKAGE
mkdir $LEININGEN_HOME
mv $LEININGEN_PACKAGE $LEININGEN_HOME

ln -s $LEININGEN_HOME/lein /usr/bin/lein

echo "leiningen $LEININGEN_VERSION installed"

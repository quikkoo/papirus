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

dependencies curl gzip tar

set -e

   NODE_HOME="/opt/node"
NODE_VERSION="$1"
NODE_PACKAGE="/tmp/node-$NODE_VERSION.tar.gz"
NODE_TARBALL="https://nodejs.org/download/release/v$NODE_VERSION/node-v$NODE_VERSION-linux-x64.tar.gz"

curl -sSL $NODE_TARBALL -o $NODE_PACKAGE
tar -xzf $NODE_PACKAGE -C /opt
mv /opt/node-v$NODE_VERSION-linux-x64 $NODE_HOME

rm $NODE_PACKAGE

for ENTRY in $NODE_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $NODE_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "node $NODE_VERSION installed"

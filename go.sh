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

   GO_HOME="/opt/golang"
GO_VERSION="$1"
GO_PACKAGE="/tmp/golang-$GO_VERSION.tar.gz"
GO_TARBALL="http://storage.googleapis.com/golang/go$GO_VERSION.linux-amd64.tar.gz"

curl -sSL $GO_TARBALL -o $GO_PACKAGE
tar -xzf $GO_PACKAGE -C /opt
mv /opt/go $GO_HOME

rm $GO_PACKAGE

for ENTRY in $GO_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $GO_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "go $GO_VERSION installed"

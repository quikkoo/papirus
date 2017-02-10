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

dependencies curl java gzip tar

set -e

SCALA_HOME="/opt/scala"
SCALA_VERSION="$1"
SCALA_PACKAGE="/tmp/scala-$SCALA_VERSION.tgz"
SCALA_TARBALL="http://www.scala-lang.org/files/archive/scala-$SCALA_VERSION.tgz"

curl -sSL $SCALA_TARBALL -o $SCALA_PACKAGE
tar -xzf $SCALA_PACKAGE -C /opt
mv /opt/scala-$SCALA_VERSION $SCALA_HOME

rm -rf $SCALA_HOME/man $SCALA_HOME/doc $SCALA_HOME/bin/*.bat
rm $SCALA_PACKAGE

for ENTRY in $SCALA_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $SCALA_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "scala $SCALA_VERSION installed"

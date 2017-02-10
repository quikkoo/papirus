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

   SBT_HOME="/opt/sbt"
SBT_VERSION="$1"
SBT_PACKAGE="/tmp/sbt-$SBT_VERSION.tgz"
SBT_TARBALL="https://dl.bintray.com/sbt/native-packages/sbt/$SBT_VERSION/sbt-$SBT_VERSION.tgz"

curl -sSL $SBT_TARBALL -o $SBT_PACKAGE
tar -xzf $SBT_PACKAGE -C /opt

rm -f $SBT_HOME/bin/*.bat
rm $SBT_PACKAGE

for ENTRY in $SBT_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $SBT_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "sbt $SBT_VERSION installed"

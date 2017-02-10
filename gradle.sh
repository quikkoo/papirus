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

dependencies curl java unzip

set -e

   GRADLE_HOME="/opt/gradle"
GRADLE_VERSION="$1"
GRADLE_PACKAGE="/tmp/gradle-$GRADLE_VERSION.zip"
GRADLE_TARBALL="http://services.gradle.org/distributions/gradle-$GRADLE_VERSION-bin.zip"

curl -sSL $GRADLE_TARBALL -o $GRADLE_PACKAGE
unzip -q $GRADLE_PACKAGE -d /opt
mv /opt/gradle-$GRADLE_VERSION $GRADLE_HOME

rm -f $GRADLE_HOME/bin/*.bat
rm $GRADLE_PACKAGE

for ENTRY in $GRADLE_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $GRADLE_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "gradle $GRADLE_VERSION installed"

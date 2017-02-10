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

   MAVEN_HOME="/opt/maven"
MAVEN_VERSION="$1"
MAVEN_PACKAGE="/tmp/maven-$MAVEN_VERSION.tar.gz"
MAVEN_TARBALL="https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries/apache-maven-$MAVEN_VERSION-bin.tar.gz"

curl -sSL $MAVEN_TARBALL -o $MAVEN_PACKAGE
tar -xzf $MAVEN_PACKAGE -C /opt
mv /opt/apache-maven-$MAVEN_VERSION $MAVEN_HOME

rm -f $MAVEN_HOME/bin/*.bat $MAVEN_HOME/bin/*.cmd
rm $MAVEN_PACKAGE

for ENTRY in $MAVEN_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $MAVEN_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "maven $MAVEN_VERSION installed"

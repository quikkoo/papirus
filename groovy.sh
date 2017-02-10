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

# support old versions before it had been moved to apache
case $1 in
  2.4.[4-7])
    APACHE_GROOVY="apache-groovy-binary"
    ;;
  *)
    APACHE_GROOVY="groovy-binary"
    ;;
esac

   GROOVY_HOME="/opt/groovy"
GROOVY_VERSION="$1"
GROOVY_PACKAGE="/tmp/groovy-$GROOVY_VERSION.zip"
GROOVY_TARBALL="http://dl.bintray.com/groovy/maven/$APACHE_GROOVY-$GROOVY_VERSION.zip"

curl -sSL $GROOVY_TARBALL -o $GROOVY_PACKAGE
unzip -q $GROOVY_PACKAGE -d /opt
mv /opt/groovy-$GROOVY_VERSION $GROOVY_HOME

rm -r $GROOVY_HOME/bin/*.bat
rm $GROOVY_PACKAGE

for ENTRY in $GROOVY_HOME/bin/*
do
  if [ -x $ENTRY ]
  then
    CMD=$(basename $ENTRY)
    ln -s $GROOVY_HOME/bin/$CMD /usr/bin/$CMD
  fi
done

echo "groovy $GROOVY_VERSION installed"

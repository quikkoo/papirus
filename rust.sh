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

   RUST_HOME="/opt/rust"
RUST_VERSION="$1"
RUST_PACKAGE="/tmp/rust-$RUST_VERSION.tar.gz"
RUST_TARBALL="https://static.rust-lang.org/dist/rust-$RUST_VERSION-x86_64-unknown-linux-gnu.tar.gz"

curl -sSL $RUST_TARBALL -o $RUST_PACKAGE
tar -xzf $RUST_PACKAGE -C /opt
mv /opt/rust-$RUST_VERSION-x86_64-unknown-linux-gnu $RUST_HOME
sh $RUST_HOME/install.sh

rm $RUST_PACKAGE

echo "rust $RUST_VERSION installed"

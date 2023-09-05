#!/bin/bash

set -e
set -x

VERSION=2.6.7

wget -O bochs-${VERSION}.tar.gz "http://downloads.sourceforge.net/project/bochs/bochs/${VERSION}/bochs-${VERSION}.tar.gz"
tar -xvzf bochs-${VERSION}.tar.gz
pushd bochs-${VERSION}/

if [[ $(uname -m) =~ ^arm|^aarch ]]; then
  ./configure --enable-gdb-stub --with-x --with-x11 --with-term --with-nogui --build=aarch64-unknown-linux-gnu
else
  ./configure --enable-gdb-stub --with-x --with-x11 --with-term --with-nogui --build=x86_64-unknown-linux-gnu
fi

make install

# Clean up
popd
rm bochs-${VERSION}.tar.gz
rm -rf bochs-${VERSION}/

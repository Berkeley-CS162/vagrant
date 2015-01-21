#!/bin/bash

set -x

VERSION=2.6.7

wget -O bochs-${VERSION}.tar.gz "http://downloads.sourceforge.net/project/bochs/bochs/${VERSION}/bochs-${VERSION}.tar.gz"
tar -xvzf bochs-${VERSION}.tar.gz
cd bochs-${VERSION}/

./configure --enable-gdb-stub --with-x --with-x11 --with-term --with-nogui
sudo make install

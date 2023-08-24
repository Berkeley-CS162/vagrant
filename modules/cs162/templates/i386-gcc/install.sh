#!/bin/bash

mkdir /i386

cd /i386

export CC=/bin/gcc
export LD=/bin/gcc
export PREFIX="/usr/local/i386elfgcc"
export TARGET=i386-elf
export PATH="$PREFIX/bin:$PATH"
curl -O http://ftp.gnu.org/gnu/binutils/binutils-2.40.tar.gz
tar -xf binutils-2.40.tar.gz
mkdir binutils-build
cd binutils-build
../binutils-2.40/configure --target=$TARGET --enable-interwork --enable-multilib --disable-nls --disable-werror --prefix=$PREFIX 2>&1 | tee configure.log
sudo make all install 2>&1 | tee make.log

# Building gcc for i386
cd /i386
wget https://ftp.gnu.org/gnu/gcc/gcc-11.3.0/gcc-11.3.0.tar.gz
tar xzf gcc-11.3.0.tar.gz
cd gcc-11.3.0
./contrib/download_prerequisites
cd ..
mkdir objdir
cd objdir
../gcc-11.3.0/configure --target=$TARGET --prefix="$PREFIX" --disable-nls --disable-libssp --enable-languages=c --without-headers
make all-gcc
make all-target-libgcc
sudo make install-gcc
sudo make install-target-libgcc

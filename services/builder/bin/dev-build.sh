#!/bin/bash


BUILD_DEST=/runtime/data/run

MOUNTED_MANGOS=/runtime/data

source /runtime/etc/configrc
cd $MOUNTED_MANGOS
echo "Building Mangos"
mkdir -p ./build
cd ./build
cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../mangos/run -DPCH=1 -DDEBUG=0
make
make install
cd ..
rm -rf $BUILD_DEST/
mkdir -p $BUILD_DEST
mv ./mangos/run/* $BUILD_DEST/
echo Done.
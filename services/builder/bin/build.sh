#!/bin/bash

BUILD_DEST=/runtime/data/run
mkdir $BUILD_DEST

source /runtime/etc/configrc
echo "Cloning Mangos Repos"
git clone $GITHUB_CMANGOS ./mangos
echo "Building Mangos"
mkdir -p ./build
cd ./build
cmake ../mangos -DCMAKE_INSTALL_PREFIX=\../mangos/run -DBUILD_EXTRACTORS=ON -DPCH=1 -DDEBUG=0 -DBUILD_PLAYERBOT=ONs
make
make install
cd ..
mv ./mangos/run/* $BUILD_DEST/
echo Done.
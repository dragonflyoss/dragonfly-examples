#!/bin/bash

curDir=$(cd "$(dirname "$0")" && pwd)

test -d /etc/dragonfly || mkdir -p /etc/dragonfly
test -d ./build || mkdir -p build/supernode
ln -s $curDir/build/supernode /tmp/dragonfly

cd build
git clone https://github.com/dragonflyoss/Dragonfly
cd Dragonfly

make USE_DOCKER=1 build-client
make build-supernode

echo "copy config files"
cp $curDir/conf/dragonfly/* /etc/dragonfly/*

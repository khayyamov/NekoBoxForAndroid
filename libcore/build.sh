#!/bin/bash

go mod tidy

source ../buildScript/init/env_ndk.sh

BUILD=".build"

rm -rf $BUILD/android \
  $BUILD/java \
  $BUILD/javac-output \
  $BUILD/src

gomobile bind -v -androidapi 21 -cache $(realpath $BUILD) -trimpath -ldflags='-s -w' -tags='with_conntrack,with_gvisor,with_quic,with_wireguard,with_utls,with_clash_api,with_ech' . || exit 1
rm -r libv2ray-sources.jar

proj=../app/libs
mkdir -p $proj
cp -f libv2ray.aar $proj
echo ">> install $(realpath $proj)/libv2ray.aar"

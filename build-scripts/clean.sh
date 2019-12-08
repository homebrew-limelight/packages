#!/bin/bash

if [ "${USING_DEBIAN:-0}" -eq "1" ]; then
    cd opensight/package
    dh clean
    cd ../../
    cd opensight-server/package
    dh clean
    cd ../../
fi

rm -rf packages
rm -rf opensight/*opensight*
rm -rf opensight-server/*opensight-server*
rm -rf opencv/build
rm -rf python-packages/build
rm -f dependencies/dependencies

#!/bin/bash

if [ "${USING_DEBIAN:-0}" -eq "1" ]; then
    cd opensight/package
    dh clean
    cd ../../
fi

rm -rf packages
rm -rf opensight/*opensight*
rm -f opensight/package/debian/changelog
rm -rf opencv/build
rm -rf python-packages/build
rm -f dependencies/dependencies
rm -rf potential-engine/p-e/src
rm -rf potential-engine/fmt/src

#!/usr/bin/env bash
set -e

cd p-e
rm -rf src
git clone https://github.com/BHSSFRC/potential-engine src

cd src
VERSION="$(git describe --tags $(git rev-list --tags --max-count=1))"
mkdir -p build
cd ..

cmake -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_TOOLCHAIN_FILE="../../arm.cmake" \
    -D CPACK_BINARY_DEB=ON \
    -D CPACK_GENERATOR="DEB" \
    -D CPACK_DEBIAN_PACKAGE_MAINTAINER="Steven Spangler" \
    -D CPACK_DEBIAN_PACKAGE_NAME="potential-engine" \
    -D CPACK_DEBIAN_PACKAGE_ARCHITECTURE="armhf" \
    -B "src/build/" \
    -S "src"

make -j$(nproc) -C "src/build/"
make -C "src/build/" package

cd ..
mv "p-e/src/build/potential-engine"*".deb" "../packages/potential-engine_${VERSION:1}_armhf.deb"
rm -rf src/

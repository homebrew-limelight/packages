#!/usr/bin/env bash
set -e

cd fmt
rm -rf src
git clone https://github.com/fmtlib/fmt src

cd src
mkdir -p build
cd ..

cmake -D CMAKE_BUILD_TYPE=Release \
    -D CMAKE_TOOLCHAIN_FILE="../../arm.cmake" \
    -D CPACK_BINARY_DEB=ON \
    -D CPACK_GENERATOR="DEB" \
    -D CPACK_DEBIAN_PACKAGE_MAINTAINER="Steven Spangler" \
    -D CPACK_DEBIAN_PACKAGE_NAME="fmt" \
    -D CPACK_DEBIAN_PACKAGE_ARCHITECTURE="armhf" \
    -B "src/build/" \
    -S "src"

make -j$(nproc) -C "src/build/"
make -C "src/build/" package

cd ..
# fmt is compile AND runtime dep for p-e
dpkg -i "fmt/src/build/fmt"*".deb"
mv "fmt/src/build/fmt"*".deb" "../packages/fmt_master_armhf.deb"
rm -rf src/

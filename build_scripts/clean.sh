#1/usr/bin/env sh

cd opensight/package
dh clean
cd ../../

rm -rf packages
rm -rf opensight/*opensight*
rm -rf python-packages
rm -rf opencv-build/build
rm -f dependencies

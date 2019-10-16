#1/usr/bin/env sh

cd opensight/package
dh clean
cd ../../

rm -rf packages
rm -rf opensight/*opensight*
rm -rf python-packages/build
rm -rf opencv/build
rm -f dependencies

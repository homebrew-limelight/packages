#1/usr/bin/env sh

cd opensight/package
dh clean
cd ../../

rm -rf packages
rm -rf opensight/*opsi*
rm -rf python-packages
sudo rm -rf opencv-build/build

rm dependencies

#1/usr/bin/env sh

cd manager/package
dh clean
cd ../../

rm -rf packages
rm -rf manager/*opsi*
rm -rf python-packages

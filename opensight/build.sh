#!/bin/bash -e

cd opensight/package
dpkg-buildpackage -us -uc --build=all

cd ../../
mv opensight/*.deb packages/

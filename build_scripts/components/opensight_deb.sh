#!/usr/bin/env bash

set -e

cd opensight/package
dpkg-buildpackage -us -uc -b -a armhf

cd ../../
mv opensight/*.deb packages/

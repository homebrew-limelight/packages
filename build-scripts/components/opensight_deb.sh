#!/usr/bin/env bash

set -e

cd opensight/package
dpkg-buildpackage -us -uc --build=all

cd ../../
mv opensight/*.deb packages/

#!/usr/bin/env bash

set -e

cd manager/package
dpkg-buildpackage -us -uc -b -a armhf
mv manager/*.deb packages/

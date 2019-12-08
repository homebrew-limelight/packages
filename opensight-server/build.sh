#!/bin/bash -e

cd opensight-server/package

git log --no-walk --tags --pretty="opensight-server (%S) unstable; urgency=medium%n%n  * See the full changelog at:%n  * https://github.com/opensight-cv/opensight/releases/tag/v%S%n%n -- Daniel Zilberleyb <me@danielz.pw>  %cD%n" --decorate=off | sed 's/(v/(/g' | sed 's/\/v/\//g' > debian/changelog

dpkg-buildpackage -us -uc --build=all
dh clean

cd ../../
mv opensight-server/*.deb packages/

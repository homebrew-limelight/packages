#!/bin/bash -e

cd opensight/package

git log --no-walk --tags --pretty="opensight (%S) unstable; urgency=medium%n%n  * See the full changelog at:%n  * https://github.com/opensight-cv/opensight/releases/tag/v%S%n%n -- Steven Spangler <132@ikl.sh>  %cD%n" --decorate=off | sed 's/(v/(/g' | sed 's/\/v/\//g' > debian/changelog

dpkg-buildpackage -us -uc --build=all
dh clean

cd ../../
mv opensight/*.deb packages/


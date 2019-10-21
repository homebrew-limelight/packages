#!/bin/bash -e

cd opensight/package

git log --no-walk --tags --pretty="opensight (%D) unstable; urgency=medium%n%n  * See the full changelog at:%n  * https://github.com/opensight-cv/opensight/releases/tag/%D%n%n -- Steven Spangler <132@ikl.sh>  %cD%n" --decorate=off | sed 's/tag: //g' | sed 's/(v/(/g' | sed -r 's/([0-9]+\.[0-9]+\.[0-9]+), v[0-9]+\.[0-9]\.[0-9]+/\1/g' > debian/changelog

dpkg-buildpackage -us -uc --build=all

cd ../../
mv opensight/*.deb packages/

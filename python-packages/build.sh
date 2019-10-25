#!/usr/bin/env bash

set -e

cd python-packages
mkdir -p build
rm -rf build/**/deb_dist/

# Set version to '' for latest
declare -A packages=( [starlette]='0.*' [pydantic]='0.*' [fastapi]='0.*' [uvicorn]='0.*' [toposort]='1.*' [pynetworktables]='2019.*' [python-multipart]='0.*' )
if [ "$1" == "--armhf" ]; then
    declare -A packages=( [pystemd]='0.*' )
fi
for i in "${!packages[@]}"; do
	package="$i"
	version="${packages[$i]}"
	mkdir -p "build/$package"
	if [ "$version" == "" ]; then
		pip3 download --no-binary=:all: "$package" -d "build/$package"
	else
		pip3 download --no-binary=:all: "$package==$version" -d "build/$package"
	fi
	py2dsc-deb -d "build/$package/deb_dist" build/"$package"/"$package"*.tar.gz
	cp build/"$package"/deb_dist/*.deb ../packages/
done

cd ../

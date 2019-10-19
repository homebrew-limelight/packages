#!/usr/bin/env bash

set -e

cd python-packages
mkdir -p build
rm -rf build/**/deb_dist/

# Set version to '' for latest
declare -A packages=( [starlette]='' [pydantic]='' [fastapi]='' [uvicorn]='' [toposort]='' [pynetworktables]='' [python-multipart]='' )
if [ "$1" == "--armhf" ]; then
    declare -A packages=( [pystemd]='' )
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

#!/usr/bin/env bash

set -e

mkdir -p python-packages

# Set version to '' for latest
declare -A packages=( [starlette]='' [pydantic]='' [fastapi]='' [uvicorn]='' [toposort]='' [pynetworktables]='' [python-multipart]='' )
for i in "${!packages[@]}"; do
	package="$i"
	version="${packages[$i]}"
	mkdir -p "python-packages/$package"
	if [ "$version" == "" ]; then
		pip3 download --no-binary=:all: "$package" -d "python-packages/$package"
	else
		pip3 download --no-binary=:all: "$package==$version" -d "python-packages/$package"
	fi
	py2dsc-deb -d "python-packages/$package/deb_dist" python-packages/"$package"/"$package"*.tar.gz
	cp python-packages/"$package"/deb_dist/*.deb packages/
done

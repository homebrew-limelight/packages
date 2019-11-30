#!/bin/bash -e

# Usage: build-scripts/build_component.sh [COMPONENT] [URL] [USERNAME] [PASSWORD] [DOCKER]

# get env vars but don't build
if [ "$5" == "DOCKER" ]; then
    source ./build.sh -t --no-build --docker
elif [ ! -z "$2" ]; then
    source ./build.sh -t --no-build
else 
    source ./build.sh --no-build
fi

mkdir -p packages
build-scripts/components/$1.sh

if [ "$USING_TRAVIS" -eq "1" ]; then
    for file in packages/*; do
        curl -T $file -c /dev/null --digest -u $3:$4 $2
    done
fi

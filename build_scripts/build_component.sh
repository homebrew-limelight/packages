#!/bin/bash -e

# Usage: build_scripts/build_component.sh [COMPONENT] [URL] [USERNAME] [PASSWORD]

build_scripts/start_build.sh
build_scripts/components/$1.sh

for file in packages/*; do
    curl -T $file -c /dev/null --digest -u $3:$4 $2
done

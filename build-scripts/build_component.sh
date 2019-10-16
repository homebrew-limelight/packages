#!/bin/bash -e

# Usage: build-scripts/build_component.sh [COMPONENT] [URL] [USERNAME] [PASSWORD]

mkdir -p packages
build-scripts/components/$1.sh

for file in packages/*; do
    curl -T $file -c /dev/null --digest -u $3:$4 $2
done

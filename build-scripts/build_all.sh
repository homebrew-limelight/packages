#!/bin/bash -e

mkdir -p packages

for i in build-scripts/components/*; do
    ./$i
done

build-scripts/create_assets.sh
build-scripts/clean.sh

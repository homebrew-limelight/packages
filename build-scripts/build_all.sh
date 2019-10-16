#!/usr/bin/env bash
set -e

mkdir -p packages

for i in build-scripts/components/*; do
    ./$i
done

build-scripts/make_packages.sh
build-scripts/clean.sh

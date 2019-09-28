#!/usr/bin/env bash
set -e

mkdir -p packages

for i in build_scripts/components/*; do
    ./$i
done

build_scripts/make_packages.sh
build_scripts/clean.sh

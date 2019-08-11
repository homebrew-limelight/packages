#!/usr/bin/env bash -e

build_scripts/start_build.sh

for i in build_scripts/components/*; do
    ./$i
done

build_scripts/make_packages.sh
build_scripts/clean.sh

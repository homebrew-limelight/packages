#!/usr/bin/env bash

set -e

mkdir -p packages

for i in build_scripts/*; do
    ./$i
done

./make_packages.sh
./clean.sh

#!/usr/bin/env bash
set -e

cd potential-engine

./fmt/build.sh
./p-e/build.sh

chmod -R 777 fmt/src p-e/src

cd ..

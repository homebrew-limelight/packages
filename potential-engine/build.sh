#!/usr/bin/env bash
set -e

cd potential-engine

./fmt/build.sh
./p-e/build.sh

cd ..

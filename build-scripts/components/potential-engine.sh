#!/bin/bash -e

if [ "$USING_DEBIAN" -eq "1" ]; then
    potential_engine/build.sh
else
    ${DOCKER} build -t opsi-main docker/main
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-pe" \
        opsi-main \
        bash -e -o pipefail -c \
        "cd packages; potential-engine/build.sh"
fi

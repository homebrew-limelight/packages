#!/bin/bash -e

if [ "$USING_ARM" -eq "1" ]; then
    rusty-engine/build.sh
else
    rm -f docker/arm/qemu-arm-static
    cp /usr/bin/qemu-arm-static docker/arm/qemu-arm-static
    ${DOCKER} build -t opsi-arm:latest docker/arm
    rm docker/arm/qemu-arm-static

    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-rusty-engine-arm" \
        opsi-arm \
        bash -e -o pipefail -c \
        "cd /packages/; rusty-engine/build.sh; chmod -R 777 rusty-engine/build" # run chmod 777 since root owns when done in docker
fi

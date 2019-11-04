#!/bin/bash -e

if [ "$USING_DEBIAN" -eq "1" ]; then
    python-packages/build.sh
else
    ${DOCKER} build -t opsi-main docker/main
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-python-main" \
        opsi-main \
        bash -e -o pipefail -c \
        "cd /packages/; OPENSIGHT_VERSION=$OPENSIGHT_VERSION python-packages/build.sh; chmod -R 777 python-packages/build" # run chmod 777 since root owns when done in docker
fi

if [ "$USING_ARM" -eq "1" ]; then
    python-packages/build.sh --armhf
else
    rm -f docker/arm/qemu-arm-static
    cp /usr/bin/qemu-arm-static docker/arm/qemu-arm-static
    ${DOCKER} build -t opsi-arm:latest docker/arm
    rm docker/arm/qemu-arm-static

    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-python" \
        opsi-arm \
        bash -e -o pipefail -c \
        "cd /packages/; OPENSIGHT_VERSION=$OPENSIGHT_VERSION python-packages/build.sh --armhf; chmod -R 777 python-packages/build" # run chmod 777 since root owns when done in docker
fi

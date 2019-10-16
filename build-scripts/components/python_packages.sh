#!/bin/bash -e


OPENCV_VERSION="4.1.1"
DOCKER="docker"

if ! ${DOCKER} ps >/dev/null 2>&1; then
        DOCKER="sudo docker"
fi
if ! ${DOCKER} ps >/dev/null; then
        echo "error connecting to docker:"
        ${DOCKER} ps
        exit 1
fi

rm -f python-packages/qemu-arm-static
cp /usr/bin/qemu-arm-static python-packages/qemu-arm-static
${DOCKER} build -t opsi-python:latest python-packages
rm python-packages/qemu-arm-static

if $(uname -m | grep -q -e "arm" -e "aarch"); then
    python-packages/build.sh
    python-packages/build.sh --armhf
else
    python-packages/build.sh
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-python-work" \
        opsi-python:latest \
        bash -e -o pipefail -c "cd /packages/; python-packages/build.sh --armhf && chmod -R 777 python-packages/build"
fi

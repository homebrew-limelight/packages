#!/bin/bash -e

if [ "$USING_DEBIAN" -eq "1" ]; then
    opensight/build.sh
else
    ${DOCKER} build -t opsi-main docker/main
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-deb" \
        opsi-main \
        bash -e -o pipefail -c \
        "cd packages; OPENSIGHT_VERSION=${OPENSIGHT_VERSION} opensight/build.sh"
fi

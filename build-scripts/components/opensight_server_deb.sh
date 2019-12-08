#!/bin/bash -e

BRANCH="v${OPENSIGHT_VERSION}"
if [[ "${OPENSIGHT_VERSION}" == "master" ]]; then
    BRANCH="${OPENSIGHT_VERSION}"
    OPENSIGHT_VERSION="0.0.0"
fi

if [ "$USING_DEBIAN" -eq "1" ]; then
    BRANCH=${BRANCH} opensight-server/build.sh
else
    ${DOCKER} build -t opsi-main-git docker/main-git
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-deb" \
        opsi-main-git \
        bash -e -o pipefail -c \
        "cd packages; BRANCH=${BRANCH} OPENSIGHT_VERSION=${OPENSIGHT_VERSION} opensight-server/build.sh"
fi

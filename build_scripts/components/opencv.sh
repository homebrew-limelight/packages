#!/bin/bash -e

DOCKER="docker"

if ! ${DOCKER} ps >/dev/null 2>&1; then
        DOCKER="sudo docker"
fi
if ! ${DOCKER} ps >/dev/null; then
        echo "error connecting to docker:"
        ${DOCKER} ps
        exit 1
fi

${DOCKER} build -t opsi-opencv opencv-build
${DOCKER} run --rm --privileged \
    --volume "$(pwd)":/packages \
    --name "opencv-build_work" \
    opsi-opencv \
    bash -e -o pipefail -c "cd /packages/opencv-build/; ./build.sh"

#!/bin/bash -e

if [ ! -e "cache/opencv-python_${OPENCV_VERSION}_armhf.deb" ]; then
    if [ "$USING_DEBIAN" -eq "1" ]; then
        opencv/build.sh
    else 
        ${DOCKER} build -t opsi-main docker/main
        ${DOCKER} run --rm --privileged \
            --volume "$(pwd)":/packages \
            --name "opsi-opencv" \
            opsi-main \
            bash -e -o pipefail -c \
            "cd /packages; export OPENCV_VERSION=${OPENCV_VERSION}; opencv/build.sh"
    fi
fi

cp "cache/opencv-python_${OPENCV_VERSION}_armhf.deb" "packages/opencv-python_${OPENCV_VERSION}_armhf.deb"
cp "cache/opencv-libs_${OPENCV_VERSION}_armhf.deb" "packages/opencv-libs_${OPENCV_VERSION}_armhf.deb"

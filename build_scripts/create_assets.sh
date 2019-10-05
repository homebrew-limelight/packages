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


date=$(date +%F)

mkdir -p packages/deps
curl -c /dev/null --digest -u travis:$TFG_PASSWORD http://ikl.sh:5000/download/cigroup --output opsi-packages-$date.tar.gz
tar -xf opsi-packages-$date.tar.gz -C packages/deps/

${DOCKER} run --rm --privileged \
    --volume "$(pwd)":/packages \
    --name "opsi-depends" \
    debian:buster \
    bash -e -o pipefail -c \
    'dpkg --add-architecture armhf; cd packages/; build_scripts/get_dependencies.sh packages/'


cd packages
tar czf ../opsi-packages-with-dependencies-$date.tar.gz *
cd ../../

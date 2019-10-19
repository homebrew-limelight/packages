#!/bin/bash -e

date=$(date +%F)

if [ "$1" == "--travis" ]; then
    source ./build.sh --no-build -t -w
fi

mkdir -p packages/deps
mkdir -p build
if [ "$USING_TRAVIS" -eq "1" ]; then
    curl -c /dev/null --digest -u travis:$TFG_PASSWORD http://ikl.sh:5000/download/cigroup --output opsi-packages-$date.tar.gz
    tar xf opsi-packages-$date.tar.gz -C packages/
    rm opsi-packages-$date.tar.gz
fi
cd packages/
cp -rf *.* deps/
rm -f *.*
tar czf ../build/opsi-packages-$date.tar.gz *
cd ../

if [ "$WITH_DEPENDENCIES" -eq "0" ]; then
    exit 0
fi

# TODO: Respect Debian settings
# if [ "$USING_DEBIAN" -eq "1" ]; then
#     sudo dependencies/build.sh
# else
    ${DOCKER} build -t opsi-main docker/main
    ${DOCKER} run --rm --privileged \
        --volume "$(pwd)":/packages \
        --name "opsi-depends" \
        opsi-main \
        bash -e -o pipefail -c \
        'cd packages/; dependencies/build.sh'
# fi


cd packages
tar czf ../build/opsi-packages-with-dependencies-$date.tar.gz *
cd ../../

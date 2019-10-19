#!/bin/bash -e

# -----------VERSIONS------------
export OPENSIGHT_VERSION="0.0.18"
export OPENCV_VERSION="4.1.1"
# -------------------------------


# -----------ARGUMENTS-----------
ALWAYS_DOCKER=0
WITH_DEPENDENCIES=0
USING_TRAVIS=0
NOBUILD=0
while [ $# -gt 0 ]; do
    case $1 in
        -d|--docker) ALWAYS_DOCKER=1 ;;
        -w|--with-dependencies) WITH_DEPENDENCIES=1 ;;
        -t|--travis) USING_TRAVIS=1 ;;
        -n|--no-build) NOBUILD=1 ;;
        (--) shift; break;;
        (-*) echo "$0: unrecognized option $1" 1>&2; exit 1;;
        (*) break;;
    esac
    shift
done
export ALWAYS_DOCKER
export WITH_DEPENDENCIES
export USING_TRAVIS
# -------------------------------


# ------------DOCKER-------------
DOCKER="docker"
if ! ${DOCKER} ps >/dev/null 2>&1; then
        DOCKER="sudo docker"
fi
if ! ${DOCKER} ps >/dev/null; then
        echo "error connecting to docker:"
        ${DOCKER} ps
        exit 1
fi
export DOCKER
# -------------------------------


# ----------SYSTEM VARS----------
USING_ARM=0
USING_DEBIAN=0
uname -m
if $(uname -m | grep -q -e "arm" -e "aarch") && [ "$ALWAYS_DOCKER" -eq "0" ]; then
    USING_ARM=1
fi
if [ "$(grep -Ei 'raspbian|debian|buntu|mint' /etc/*release)" ] && [ "$ALWAYS_DOCKER" -eq "0" ]; then
    USING_DEBIAN=1
fi
export USING_ARM
export USING_DEBIAN
# -------------------------------

if [ "$NOBUILD" -eq "0" ]; then
    build-scripts/build_all.sh
fi

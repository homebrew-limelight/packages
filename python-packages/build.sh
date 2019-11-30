#!/usr/bin/env bash

# exit on fail
set -e

same_minor_ver() {
    major1=$(echo $1 | cut -d'.' -f1)
    major2=$(echo $2 | cut -d'.' -f1)
    minor1=$(echo $1 | cut -d'.' -f2)
    minor2=$(echo $2 | cut -d'.' -f2)
    if [ "$major1" != "$major2" ] && [ "$major1" != "*" ]; then return 1; fi
    if [ "$minor1" != "$minor2" ] && [ "$minor1" != "*" ]; then return 1; fi
    return 0
}

# setup
cd python-packages
rm -rf build
mkdir -p build

# get requirements.txt from current version
if [[ "${OPENSIGHT_VERSION}" != "master" ]]; then
    OPENSIGHT_VERSION="v${OPENSIGHT_VERSION}"
fi
git clone --depth 1 --branch "${OPENSIGHT_VERSION}" https://github.com/opensight-cv/opensight src/ 2>/dev/null 1>/dev/null
mv src/requirements.txt build/requirements.txt
rm -rf src

# get versions for raspbian packages
if [[ ! -f ../cache/Packages.gz ]]; then
    curl -o ../cache/Packages.gz http://archive.raspbian.org/raspbian/dists/buster/main/binary-armhf/Packages.gz
fi
cp ../cache/Packages.gz build/

# Set version to '' for latest
declare -A packages
for line in $(cat build/requirements.txt); do
    PKG=$(echo $line | cut -d'=' -f 1)
    VER=$(echo $line | cut -d'=' -f 3)
    packages[$PKG]=$VER
done
rm build/requirements.txt

# if run in armhf mode only build packages shown, remove otherwise
armhf_only=( pystemd )
if [ "$1" == "--armhf" ]; then
    # TODO REMOVE
    declare -A temppkgs
    for i in ${armhf_only[@]}; do
        ver=${packages[$i]}
        temppkgs[$i]=$ver
    done
    unset packages
    declare -A packages
    for i in ${!temppkgs[@]}; do
        packages[$i]=${temppkgs[$i]}
    done
else
    for i in ${armhf_only[@]}; do
        unset packages[$i]
    done
fi

touch build/requirements.txt
for i in "${!packages[@]}"; do
    package="$i"
    version="${packages[$i]}"

    echo Running requirement check for ${package,,}...

    # get installable version of existing python packages, and remove extraneous build info (eg. debian build numbers)
    # ensure exact match, so you don't get random but similar packages
    repo_version=$(zcat build/Packages.gz | grep -A2 "^Package: python3-${i,,}$" | tail -1 | rev | cut -d ":" -f1 | rev | cut -d "-" -f1 | cut -d "+" -f1 | tr -d ' ')

    echo REQUIRED: $version AVAILABLE: $repo_version
    same_minor_ver $version $repo_version && echo Package available through Raspbian repository, skipping... && continue
    echo "$package==$version" >> build/requirements.txt
done

sed "s#SCRIPT_PATH#$(pwd)#g" "py2deb.ini" > "py2deb_processed.ini"
py2deb -c "./py2deb_processed.ini" -- -r build/requirements.txt
rm py2deb_processed.ini

for line in $(cat build/requirements.txt); do
    PKG=$(echo $line | cut -d'=' -f 1)
    mv "build/python3-$PKG"* "../packages/"
done

cd ../

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
mkdir -p build
rm -rf build/**/deb_dist/

# get requirements.txt from current version
git clone --depth 1 --branch "v${OPENSIGHT_VERSION}" https://github.com/opensight-cv/opensight src/ 2>/dev/null 1>/dev/null
mv src/requirements.txt build/requirements.txt
rm -rf src

# get versions for raspbian packages
curl -o build/Packages.gz http://archive.raspbian.org/raspbian/dists/buster/main/binary-armhf/Packages.gz

# Set version to '' for latest
declare -A packages
for line in $(cat build/requirements.txt); do
    PKG=$(echo $line | cut -d'=' -f 1)
    VER=$(echo $line | cut -d'=' -f 3)
    packages[$PKG]=$VER
done

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

for i in "${!packages[@]}"; do
    package="$i"
    version="${packages[$i]}"

    echo Running requirement check for ${package,,}...

    # get installable version of existing python packages, and remove extraneous build info (eg. debian build numbers)
    # ensure exact match, so you don't get random but similar packages
    repo_version=$(zcat build/Packages.gz | grep -A2 "^Package: python3-${i,,}$" | tail -1 | rev | cut -d ":" -f1 | rev | cut -d "-" -f1 | cut -d "+" -f1 | tr -d ' ')

    echo REQUIRED: $version AVAILABLE: $repo_version
    same_minor_ver $version $repo_version && echo Package available through Raspbian repository, skipping... && continue

    mkdir -p "build/$package"
    if [ "$version" == "" ]; then
        pip3 download --no-binary=:all: "$package" -d "build/$package"
    else
        pip3 download --no-binary=:all: "$package==$version" -d "build/$package"
    fi

    cd "build/$package"
    [ -e "$package"*".zip" ] && unzip build $package*.zip && rm $package*.zip
    [ -e "$package"*".tar.gz" ] && tar xf $package*.tar.gz && rm $package*.tar.gz

    cd $package*
    # ensure license doesn't get added to package (and end up in /usr/LICENSE.md)
    sed -i 's/\["LICENSE.md"\]/[]/' setup.py

    python3 setup.py --command-packages=stdeb.command bdist_deb
    if [ "$1" == "--armhf" ]; then
        cp deb_dist/python3-$package_*_armhf.deb ../../../../packages/
    else
        cp deb_dist/python3-$package_*_all.deb ../../../../packages/
    fi
    cd ../../../
done

cd ../

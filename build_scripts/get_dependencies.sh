#!/bin/bash -e

apt update

for file in $1/*; do
    #                                          Removes depends  Comma to newline   Remove all after : and (
    dpkg-deb -I "$file" | grep Depends | sed -e 's/ Depends: //' -e 's/, /\n/g' -e 's/:.*$//g' -e 's/ (.*$//g' >> dependencies
done
sort -u dependencies -o dependencies


# remove already existing deps
for file in $1/*; do
    remove="$(basename $file | sed 's/_.*$//')"
    sed -i "/$remove/d" dependencies
done

for line in $(cat dependencies); do
    apt-cache -o APT::Architecture=armhf depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances $line 2>&- | grep -v '<' | grep Depends | sed -r 's/.+Depends: //' >> dependencies
done
sort -u dependencies -o dependencies

mkdir -p packages
# fix permission errors
chown -Rv _apt:root packages
chmod -Rv 777 packages
cd packages
apt -o APT::Architecture=armhf download $(cat ../dependencies)
cd ..

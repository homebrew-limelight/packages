#!/bin/bash -e

# for downloading commands only
APT_OPTS="-o APT::Architecture=armhf"

apt update
apt install -y curl gnupg

echo "deb http://archive.raspbian.org/raspbian buster main contrib non-free" > /etc/apt/sources.list
echo "deb-src http://archive.raspbian.org/raspbian buster main contrib non-free" >> /etc/apt/sources.list
curl https://archive.raspbian.org/raspbian.public.key | apt-key add -

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
    apt-cache "$APT_OPTS" depends --recurse --no-recommends --no-suggests --no-conflicts --no-breaks --no-replaces --no-enhances $line 2>&- | grep -v '<' | grep Depends | sed -r 's/.+Depends: //' >> dependencies
done
sort -u dependencies -o dependencies

# simple (lazy) fixes
sed -i "/Pre-Depends/d" dependencies
sed -i "/armhf/!d" dependencies


mkdir -p packages
# fix permission errors
chown -Rv _apt:root packages
chmod -Rv 777 packages
cd packages
apt "$APT_OPTS" download $(cat ../dependencies)
cd ..

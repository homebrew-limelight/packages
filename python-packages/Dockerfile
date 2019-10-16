FROM arm32v7/debian:buster

ENV DEBIAN_FRONTEND noninteractive

COPY qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get -y update && \
    apt-get -y install \
        python3-pip python3-all python3-setuptools python-all \
        python3-all-dev dpkg-dev libsystemd-dev \
        debhelper fakeroot
RUN pip3 install stdeb

FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture arm64
RUN apt-get -y update && \
    apt-get -y install \
        libneon27:arm64 libneon27-dev:arm64 valgrind:arm64 \
        python3-dev python3.7-dev python3-numpy libpython3.7-dev:arm64 \
        python3-pip python-all \
        python3-all-dev dpkg-dev libsystemd-dev debhelper fakeroot \
        libtiff-dev:arm64 zlib1g-dev:arm64 libjpeg-dev:arm64 libpng-dev:arm64 libavcodec-dev:arm64 libavformat-dev:arm64 libswscale-dev:arm64 libv4l-dev:arm64 libxvidcore-dev:arm64 libx264-dev:arm64 \
        crossbuild-essential-arm64 gfortran-aarch64-linux-gnu cmake pkg-config \
        git curl gnupg unzip
RUN pip3 install stdeb

FROM arm32v7/debian:buster

ENV DEBIAN_FRONTEND noninteractive

COPY qemu-arm-static /usr/bin/qemu-arm-static

RUN apt-get -y update && \
    apt-get -y install \
        python3-pip python3-all python3-setuptools python-all \
        python3-all-dev dpkg-dev libsystemd-dev \
        debhelper fakeroot unzip git

RUN apt-get -y install libgstreamer1.0-dev \
        libgstreamer-plugins-base1.0-dev \
        gstreamer1.0-plugins-base \
        gstreamer1.0-plugins-good \
        gstreamer1.0-plugins-bad \
        gstreamer1.0-plugins-ugly \
        gstreamer1.0-libav \
        libgstrtspserver-1.0-dev
RUN pip3 install stdeb

FROM debian:buster

ENV DEBIAN_FRONTEND noninteractive

RUN dpkg --add-architecture armhf
RUN apt-get -y update && \
    apt-get -y install \
        python3-dev python3.7-dev python3-numpy libpython3.7-dev:armhf \
        python3-pip python-all \
        python3-all-dev dpkg-dev libsystemd-dev debhelper fakeroot \
        libtiff-dev:armhf zlib1g-dev:armhf libjpeg-dev:armhf libpng-dev:armhf libavcodec-dev:armhf libavformat-dev:armhf libswscale-dev:armhf libv4l-dev:armhf libxvidcore-dev:armhf libx264-dev:armhf \
        crossbuild-essential-armhf gfortran-arm-linux-gnueabihf cmake \
        gstreamer1.0-rtsp:armhf gstreamer1.0-plugins-bad:armhf gstreamer1.0-omx:armhf libgstreamer1.0-dev:armhf libgstrtspserver-1.0-dev:armhf libgstrtspserver-1.0:armhf gir1.2-gst-rtsp-server-1.0:armhf \
        git curl gnupg unzip
RUN pip3 install py2deb

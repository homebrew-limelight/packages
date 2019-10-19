# OpenSight Packages

This is where all of the packages for the OpenSight project are generated. Here is a list of what is built and provided by this repository:

* Main OpenSight package
* Latest OpenCV cross-compiled for arm
* Python packages required for OpenSight to function
* Dependencies for all of the above

# How do I upgrade an existing installation of OpenSight?

If you are running OpenSight on a Debian-based system, such as Raspbian, Ubuntu or Debian itself, you can download the latest tar.gz file from the [releases page](https://github.com/opensight-cv/packages/releases). If you are running Raspbian (such as using the official OpenSight image), you should choose the with-dependencies tarfile. Otherwise, choose the regular tarfile. Then, go to the Settings tab of OpenSight and upload the tarfile in the "Update" section. Finally, press the update button.

# How can I install OpenSight on a non-Raspberry Pi system?

If you are planning on using a Debian-based system, such as Ubuntu, or the Jetson Nano's operating system, you can download the latest regular tar.gz file (do not use the with-dependencies tarfile, as that is for Raspbian only) from the [releases page](https://github.com/opensight-cv/packages/releases). If this system has an internet connection, you can download the tarfile using `curl` or an internet browser. Otherwise, you will have to transfer the file using a USB drive or a tool such as `scp`.

Then, access the console of this machine (whether through SSH or a graphical terminal) and run these commands:
```
mkdir packages
tar xf path/to/packages.tar.gz -C packages
sudo dpkg -Ri packages/deps
sudo reboot
```
Once your machine finishes rebooting, you should now have OpenSight installed! See the documentation (TODO) for more information on how to access the OpenSight interface.

# For Developers: How can I generate my own packages?

Short Answer:
You can simply run `./build.sh --docker` to generate a normal tarfile. If you would also like to generate a tarfile with the dependencies, run `./build.sh -w --docker` to generate a tarfile with all dependencies for the armhf platform. 

Long Answer:
If you would like to make your build more efficient, you can slim the amount Docker is used in the build.

Each component uses Docker if the following criteria are **not** met:
* Main OpenSight package:
    * Must be running on a Debian system.
* Latest OpenCV cross-compiled for arm:
    * Must be running on a Debian system.
* Python Packages:
    * `all`-platform packages: Must be running on a Debian-based operating system.
    * `armhf`-platform packages: Must be running on an arm-based platform with a Debian-based operating system.
* Dependencies:
    * Must be running on an Debian-based operating system.

Some require a full-Debian system rather than any derivative because many of the dependencies, especially on arm packages, can only be easily satisfied on a Debian system. For some this is not important, such as the dependencies module, which only requires apt specifically.

In order to run without Docker, these Debian dependencies must be satisfied:
```
python3-dev python3.7-dev python3-numpy libpython3.7-dev:armhf \
python3-pip python-all \
python3-all-dev dpkg-dev libsystemd-dev debhelper fakeroot \
libtiff-dev:armhf zlib1g-dev:armhf libjpeg-dev:armhf libpng-dev:armhf libavcodec-dev:armhf libavformat-dev:armhf libswscale-dev:armhf libv4l-dev:armhf libxvidcore-dev:armhf libx264-dev:armhf \
crossbuild-essential-armhf gfortran-arm-linux-gnueabihf cmake pkg-config \
git curl gnupg
```

If you wish to skip the hassle of installing these dependencies regardless of the above criteria, just run `./build.sh --docker` or `./build.sh -w --docker`.

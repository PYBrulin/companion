#!/bin/bash

if [ $(id -u) -ne 0 ]; then
   echo >&2 "Must be run as root"
   exit 1
fi

set -e
set -x

. config.env

sudo apt-get purge -y whoopsie

# install a couple of packages from the local repo:
# JP42 comes with libcudnn7 installed so we dont need this
# sudo apt-get install -y --allow-unauthenticated libcudnn7-dev libcudnn7

# install packages common to all
pushd ../../Common/Ubuntu
 ./install_packages.sh
popd
 
# live video related packages - not needed since gstreamer and livav 1.14 are installed with Jetpack 42
# as of 201701121657, this fails to install gstreamer1.0-vaapi; remove || true when fixed.
# apt-get -y install gstreamer1.0 gstreamer1.0-libav || true

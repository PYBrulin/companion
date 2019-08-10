#!/bin/bash

if [ $(id -u) -ne 0 ]; then
   echo >&2 "Must be run as root"
   exit 1
fi

set -e
set -x

. config.env
# install meson from pip and ninja for building the code

sudo pip3 install meson
sudo pip install pymavlink
sudo apt install ninja-build

sudo -u $NORMAL_USER -H bash <<EOF
set -e
set -x

# auto start APStreamline
# we need to install a modified version of APStreamline
# includes defect fixes and the necessary adoptions for the TX2
# please also follow the wiki for APStreamline on github
pushd ~/GitHub
rm -rf adaptive-streaming
git clone https://github.com/mtbsteve/adaptive-streaming.git
pushd adaptive-streaming
meson build
cd build
meson configure -Dprefix=$HOME/start_apstreamline/
ninja install # installs to ~/start_apstreamline for APWeb to spawn the process

popd
popd

EOF

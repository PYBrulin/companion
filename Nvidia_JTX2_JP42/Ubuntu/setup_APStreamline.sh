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
pushd ~/Github
rm -rf adaptive-streaming
git clone -b video_streaming https://github.com/mtbsteve/APWeb.git
pushd adaptive-streaming
meson build
cd build
meson configure -Dprefix=$HOME/start_apstreamline/
ninja install # installs to ~/start_apstreamline for APWeb to spawn the process

popd
popd

EOF


# add line below to bottom of /etc/rc.local to call start script
LINE="/bin/bash -c '~$NORMAL_USER/start_apweb/autostart_apweb.sh'"
perl -pe "s%^exit 0%$LINE\\n\\nexit 0%" -i /etc/rc.local



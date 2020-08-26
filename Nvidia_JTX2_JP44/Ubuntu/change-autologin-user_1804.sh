#!/bin/bash

set -e
set -x

# on JetPack-4.4 / Ubuntu 18.04:
# we want to autologin with apsync
GDM3_CONF=/etc/gdm3/custom.conf
if [ -f "$GDM3_CONF" ]; then
    ls $GDM3_CONF
    sudo perl -pe 's/#  AutomaticLoginEnable = true/AutomaticLoginEnable = true/' -i $GDM3_CONF
    ls $GDM3_CONF
    sudo perl -pe 's/#  AutomaticLogin = user1/AutomaticLogin = apsync/' -i $GDM3_CONF

fi

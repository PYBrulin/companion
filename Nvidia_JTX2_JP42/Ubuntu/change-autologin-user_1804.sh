#!/bin/bash

set -e
set -x

# on JetPack-4.2 / Ubuntu 18.04:
GDM3_CONF=/etc/gdm3/custom.conf
if [ -f "$GDM3_CONF" ]; then
    ls $GDM3_CONF
    sudo perl -pe 's/# TimedLoginEnable = true/TimedLoginEnable = true/' -i $GDM3_CONF
    ls $GDM3_CONF
    sudo perl -pe 's/# TimedLogin = user1/TimedLogin = apsync/' -i $GDM3_CONF
    ls $GDM3_CONF
    sudo perl -pe 's/# TimedLoginDelay = 10/TimedLoginDelay = 5/' -i $GDM3_CONF

fi

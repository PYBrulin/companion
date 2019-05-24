#!/bin/bash

set -e
set -x

# on JetPack-4.2:
LIGHTDM_CONF=/etc/lightdm/lightdm.conf.d/50-nvidia.conf
if [ -f "$LIGHTDM_CONF" ]; then
    ls $LIGHTDM_CONF
    sudo perl -pe 's/nvidia/apsync/' -i $LIGHTDM_CONF
fi

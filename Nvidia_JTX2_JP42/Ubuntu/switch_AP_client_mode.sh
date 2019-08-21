#!/bin/bash

if [ $(id -u) -ne 0 ]; then
   echo >&2 "Must be run as root"
   exit 1
fi

set -e
set -x

# this script allows to toggle between AP mode and client mode
if nmcli d | grep "ardupilot"; then
	# switch back to client mode
	nmcli connection down ardupilot
	echo 0 > /sys/module/bcmdhd/parameters/op_mode
        service network-manager restart

else
	echo 2 > /sys/module/bcmdhd/parameters/op_mode
	service network-manager restart
	sleep 5
	nmcli connection up ardupilot
fi

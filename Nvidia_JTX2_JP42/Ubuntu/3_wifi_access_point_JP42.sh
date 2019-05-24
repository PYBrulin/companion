#!/bin/bash

if [ $(id -u) -ne 0 ]; then
   echo >&2 "Must be run as root"
   exit 1
fi

set -e
set -x

. config.env

# Create a connection ardupilot
nmcli connection add type wifi ifname '*' con-name ardupilot autoconnect no ssid ardupilot
# Put it in Access Point
nmcli connection modify ardupilot 802-11-wireless.mode ap 802-11-wireless.band bg ipv4.method shared
# Set a WPA password to ardupilot 
nmcli connection modify  rdupilot 802-11-wireless-security.key-mgmt wpa-psk 802-11-wireless-security.psk ardupilot
# Enable it (run this command each time you want to enable the access point)
echo "# Invoke access point when logging in as apsync user" >> /home/apsync/.profile
echo "nmcli connection up my-hotspot" >> /home/apsync/.profile

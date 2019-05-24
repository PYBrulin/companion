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
# Enable it (requires reboot and logon under apsync)
echo "options bcmdhd op_mode=2" >> /etc/modprobe.d/bcmdhd.conf
echo "# Invoke access point when logging in as apsync user" >> /home/apsync/.profile
echo "if nmcli d | grep ardupilot; then sleep 1; else nmcli connection up ardupilot; fi" >> /home/apsync/.profile

cp ./switch_AP_client_mode.sh /home/apsync/.
chmod 777 ./switch_AP_client_mode.sh



#!/bin/bash

# WARNING: this script is run as root!
set -e
set -x

# pushd $HOME/start_apweb
# we need to include the full path since this script is executed under root from rc.local
cd /home/apsync/start_apweb
#fixed the logging 
./start_apweb.sh > ./start_apweb.log &

#:screen -L -d -m -S apweb -s /bin/bash ./start_apweb.sh >start_apweb.log 

exit 0

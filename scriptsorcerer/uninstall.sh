#!/bin/sh
#TODO kill any running processes from scriptsorcerer?
echo "Wait ten seconds. Press Ctrl+C to cancel. Do not try to cancel after it starts."
echo "10"
sleep 1
echo "9"
sleep 1
echo "8"
sleep 1
echo "7"
sleep 1
echo "6"
sleep 1
echo "5"
sleep 1
echo "4"
sleep 1
echo "3"
sleep 1
echo "2"
sleep 1
echo "1"
sleep 1
echo "0. starting uninstallation. DO NOT CTRL+C."

if [ -f "/mnt/bitdefender/bin/bd_procd.bak" ]; then
  mv "/mnt/bitdefender/bin/bd_procd.bak" "/mnt/bitdefender/bin/bd_procd"
  echo "deleted hook."
  rm -rf /mnt/ntgr/scriptsorcerer/
  echo "uninstalled. you should restart the router."
fi




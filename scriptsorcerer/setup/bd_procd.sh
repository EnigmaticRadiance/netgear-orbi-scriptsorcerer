#!/bin/sh
#this file will be overwritten if you have autoupdate.sh enabled.
#TODO maybe mount the base folder somewhere else? env variable with the path? just too long to type /mnt/ntgr/scriptsorcerer everywhere.

#for now, you HAVE to run bd_procd with the same args
#or /usr/share/armor/BD_START.sh WILL purge and redownload the folder.
#will consider hooking into this file in the future. looks like it purges AFTER the hook would have run. not quite sure.
/tmp/mnt/bitdefender/bin/bd_procd.bak "$@" &

sh /mnt/ntgr/scriptsorcerer/init/initialize.sh &

#!/bin/sh

if [ -e "/mnt/bitdefender/bin/bd_procd" ]; then
    if [ ! -e "/mnt/bitdefender/bin/bd_procd.bak" ]; then
        #should be initial install
        cp "/mnt/bitdefender/bin/bd_procd" "/mnt/bitdefender/bin/bd_procd.bak" && echo "Backup created: /mnt/bitdefender/bin/bd_procd.bak"         
        cp /mnt/ntgr/scriptsorcerer/setup/bd_procd.sh /mnt/bitdefender/bin/bd_procd 
    elif grep -q "scriptsorcerer" "/mnt/bitdefender/bin/bd_procd"; then
        echo "already hooked. lets update it."
        cp /mnt/ntgr/scriptsorcerer/setup/bd_procd.sh /mnt/bitdefender/bin/bd_procd
    fi
else
    echo "Source file not found: /mnt/bitdefender/bin/bd_procd"
fi

exit 0

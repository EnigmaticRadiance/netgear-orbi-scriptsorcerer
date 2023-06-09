#!/bin/sh
#I just feel like something here is flawed

if [ -e "/mnt/bitdefender/bin/bd_procd" ]; then
    if [ ! -e "/mnt/bitdefender/bin/bd_procd.bak" ]; then
        cp "/mnt/bitdefender/bin/bd_procd" "/mnt/bitdefender/bin/bd_procd.bak" && echo "Backup created: /mnt/bitdefender/bin/bd_procd.bak"
    else
        echo "already hooked. lets update it."
        mv /mnt/ntgr/scriptsorcerer/setup/bd_procd.sh /mnt/bitdefender/bin/bd_procd
    fi
    mv /mnt/ntgr/scriptsorcerer/setup/bd_procd.sh /mnt/bitdefender/bin/bd_procd 
else
    echo "Source file not found: /mnt/bitdefender/bin/bd_procd"
fi

exit 0

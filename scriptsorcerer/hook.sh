#!/bin/bash

if [ -e "/mnt/bitdefender/bin/bd_procd" ]; then
    if [ ! -e "/mnt/bitdefender/bin/bd_procd.bak" ]; then
        cp "/mnt/bitdefender/bin/bd_procd" "/mnt/bitdefender/bin/bd_procd.bak" && echo "Backup created: /mnt/bitdefender/bin/bd_procd.bak"
    else
        echo "scriptsorcerer is already installed. View gitlab url for uninstall directions"
    fi
    
    bd_procd_contents=$(cat "/mnt/bitdefender/bin/bd_procd")

    if echo "$bd_procd_contents" | grep -q "00-null"; then
        echo "bd_procd already hooked."
    else
        updated_contents=$(echo "$bd_procd_contents" | sed '/^#!/a \until [ -e /mnt/circle/scriptsorcerer/localinit/00-null ]; do\n    sleep 2\n\ndone\n\nfind /mnt/circle/scriptsorcerer/localinit/ -type f ! -name '\''!*\'' -exec sh -c '\''sh {} &'\'' \;')
        echo -e "$updated_contents" > "/mnt/bitdefender/bin/bd_procd"
        echo -e "Successfully installed scriptsorcerer!\nPlease click reboot on your Orbi's advanced home page to run the scripts in /mnt/circle/scriptsorcerer/localinit.\nIf you ever want to stop running a script, either add a ! to the beginning, or delete it.\n"
    fi
    
else
    echo "Source file not found: /mnt/bitdefender/bin/bd_procd"
fi

exit 0

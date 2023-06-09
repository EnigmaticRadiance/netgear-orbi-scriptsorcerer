#!/bin/sh
#I will only push releases when there is a bugfix or new feature to the main functionality of the script, not for sample script updates.
#Note that enabling will overwrite any local changes you have done to most files (not anything in /init/scripts) ((basically everything else))
#disabled by default. enable it by removing the "~" from the filename.
#I would personally recommend NOT enabling it. auto-updating from the github repo almost certainly makes your router less secure.
#Even though I would never intentionally put anything malicious in it.
#Just manually run it if you see a new update and care to update it. 
#TODO auto-update scripts? maybe include a shebang type of thing with a url & version number?

current_release_tag=$(cat /mnt/ntgr/scriptsorcerer/ver)
latest_release_tag=$(curl -sL "https://api.github.com/repos/EnigmaticRadiance/netgear-orbi-scriptsorcerer/releases/latest" | grep -o '"tag_name": "v[^"]*' | grep -o '[0-9.]*$')
#this is so trash it should be changed but it works
if [[ "$current_release_tag" != "$latest_release_tag" ]]; then
    latest_release_url="https://github.com/EnigmaticRadiance/netgear-orbi-scriptsorcerer/archive/refs/tags/v$latest_release_tag.zip"
    curl -sL "$latest_release_url" -o /tmp/scriptsorcererupd.zip
    unzip -p /tmp/scriptsorcererupd.zip -d /tmp/scriptsorcererupd
    mv -f /tmp/scriptsorcererupd/netgear-orbi-scriptsorcerer-"$latest_release_tag"/scriptsorcerer "$directory"
    rm /tmp/scriptsorcererupd.zip
    rm -r /tmp/scriptsorcererupd
    echo $latest_release_tag > /mnt/ntgr/scriptsorcerer/ver
    if [[ $(basename "$0") != "~"* ]]; then
        #this is so awful lmfao
        mv /mnt/ntgr/scriptsorcerer/init/mgmt/~autoupdate.sh /mnt/ntgr/scriptsorcerer/init/mgmt/autoupdate.sh
    fi
    sh /mnt/ntgr/scriptsorcerer/setup/hook.sh
fi
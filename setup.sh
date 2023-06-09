#!/bin/bash

directory="/mnt/ntgr/scriptsorcerer"

if [ -d "$directory" ]; then
  echo "The scriptsorcerer is already installed."
  exit 0
fi

latest_release_tag=$(curl -sL "https://api.github.com/repos/EnigmaticRadiance/netgear-orbi-scriptsorcerer/releases/latest" | grep -o '"tag_name": "[^"]*' | grep -o '[^"]*$')
latest_release_url="https://github.com/EnigmaticRadiance/netgear-orbi-scriptsorcerer/archive/refs/tags/$latest_release_tag.zip"

curl -sL "$latest_release_url" -o /tmp/scriptsorcerer.zip
unzip /tmp/scriptsorcerer.zip -d /tmp/scriptsorcerer
mv /tmp/scriptsorcerer/netgear-orbi-scriptsorcerer-"$latest_release_tag"/scriptsorcerer "$directory"
rm /tmp/scriptsorcerer.zip
rm -r /tmp/scriptsorcerer

echo $latest_release_tag > $directory/ver

find "$directory" -type f -name "*.sh" -exec chmod a+x {} +

echo "The scriptsorcerer has been downloaded and moved sucessfully. attempting hook."

sh $directory/setup/hook.sh


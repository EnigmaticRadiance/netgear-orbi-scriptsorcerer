#!/bin/bash

# Move ScriptSorcerer directory to /mnt/circle/
# One of the persistent r/w directories
mv /ScriptSorcerer /mnt/circle/
sleep 7
sh /mnt/circle/ScriptSorcerer/hook.sh
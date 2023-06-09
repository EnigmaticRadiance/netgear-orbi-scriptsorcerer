#!/bin/sh
directory=$(dirname "$0")
find "$directory" -type f -executable ! -name '~*' -exec sh -c 'sh {} &' \;
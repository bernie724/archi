#!/bin/bash
##B.Thompson
#Used to install a raw list of flatpak ids
setdir=/usr/local/archi/sets/exp
if [ -f "$setdir/$1" ]; then
setfile="$1"
else
echo "$0 installs flatpak apps from a list"
echo "Usage: $0 [set]"
ls "$setdir"
exit 1
fi

while read set; do
sudo flatpak install -y --noninteractive "$set"
done < "$setdir/$setfile"

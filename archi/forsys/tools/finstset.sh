#!/bin/bash
##B.Thompson
##Installs flatpak apps from a list of flatpak ids in a file

#variables
setdir=/tmp/sets

#functions
setusage () {
echo "$0 installs flatpak apps from a list"
echo "Usage: $0 <file.set>"
ls "$setdir"
exit 1
}
setinst () {
while read set; do
sudo flatpak install -y --noninteractive "$set"
done < "$setdir/$setfile"
exit
}

#conditions
if [ ! -d "$setdir" ]; then
mkdir -p "$setdir"
fi
if [ -f "$setdir/$1" ]; then
setfile="$1"
else
setusage
fi
setinst

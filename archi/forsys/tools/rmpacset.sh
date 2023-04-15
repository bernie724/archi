#!/bin/bash
##B.Thompson
#Used to remove pacman packages from a list
setdir=/usr/local/archi/sets
if [ -f "$setdir/$1" ]; then
setfile="$1"
else
echo "$0 REMOVES all the pacman packages from a list"
echo "Usage: $0 [set]"
ls "$setdir"
exit 1
fi

while read set; do
((sudo pacman -R --noconfirm --noprogressbar "$set" > /dev/null 2>&1) && echo "$set removed") || echo "$set failed!"
done < "$setdir/$setfile"

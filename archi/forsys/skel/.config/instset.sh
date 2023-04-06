#!/bin/bash
##B.Thompson
#Used to install a raw list of flatpak ids, no tests, just go...
setdir=/usr/local/archi/sets/ext
setfile=fbb.set
while read set; do
sudo flatpak install -y --noninteractive "$set"
done < "$setdir/$setfile"

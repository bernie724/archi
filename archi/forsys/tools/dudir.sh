#!/bin/bash
##sub-directory disk usage summary of current working dir
subdirs=/tmp/.dircon
ls -A1 > "$subdirs" 
# read subdirs using the file desc
exec 3<&0
exec 0<$subdirs
while read subsumm 
do
if [ -d "$subsumm" ]
then
du -hs "$subsumm" | grep -v ^0 #0 is a link
fi
done
echo -n "Total: "; du -hs
##partition info
df -h $PWD 
##cleanup
rm "$subdirs" 

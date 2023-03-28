#!/bin/bash
echo "I recommend You ready the disk yourself per the install manual."
echo -n "$0 are you SURE? [Y/anythingelse] "; read sddm
if [ "$sddm" = "Y" ]; then
wackydisk=/dev/sdb
(
echo d
echo
echo d
echo
echo d
echo
echo d
echo
echo w
) | fdisk "$wackydisk"
fdisk -l "$wackydisk" 2> /dev/null
echo -n "Destroyed! enter: "; read createdisk
(
echo n
echo p
echo 
echo 
echo
echo 
echo
echo w
) | fdisk "$wackydisk"
fdisk -l "$wackydisk" 2> /dev/null
echo "Created!"
else
echo "smart"
fi


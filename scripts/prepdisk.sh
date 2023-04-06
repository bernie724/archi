#!/bin/bash
source archi.conf
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
) | fdisk "$rdev"

(
echo n
echo p
echo 
echo 
echo +1024M
echo N
echo
echo t
echo af
echo n
echo p
echo 
echo
echo +1024M
echo N
echo
echo t
echo 2
echo 82
echo n
echo p
echo 
echo 
echo
echo N
echo 
echo t
echo 3
echo 83
echo
echo w
) | fdisk "$rdev"

if [ "$bpdisk" = "true" ]; then
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
) | fdisk "$bdisk"

(
echo n
echo p
echo 
echo 
echo
echo 
echo
echo w
) | fdisk "$bdisk"

fi

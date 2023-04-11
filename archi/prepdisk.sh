#!/bin/bash
##B.Thompson
##disk mangler
source archi.conf
parted --script -a optimal -- "$rdev" \
	mklabel gpt \
	mkpart primary 1MiB 1024MiB \
	mkpart primary 1024MiB 2048MiB \
	mkpart primary 2048MiB -2048s 

if [ "$fpdisk" = "true" ]; then
parted --script -a optimal -- "$bdev" \
	mklabel gpt \
	mkpart primary 1MiB -2048s 
fi

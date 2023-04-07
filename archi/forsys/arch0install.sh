#!/bin/bash
##B.Thompson
if [ $UID -ne 0 ]; then
echo "run as root!"
exit 1
fi

##start stage 2 after chroot 
idir=/usr/local/archi
cd "$idir"
source archi.conf 
source bootmisc
source packmisc
source optmisc
##time
echo "...[$0 Starting arch-chroot]"
aline
ln -sf /usr/share/zoneinfo/"$ltime" /etc/localtime
hwclock --systohc

##banner
echo "$osb" > /etc/issue

##keyboard&lang
echo "$alang $acode" >> /etc/locale.gen
locale-gen
echo "LANG=$alang" > /etc/locale.conf
echo "KEYMAP=$akeym" > /etc/vconsole.conf
echo "FONT=$afont" >> /etc/vconsole.conf
echo "$ahost" > /etc/hostname

##change root pass
aline
echo -n "changing root password..."
((echo $apass; echo $apass) | passwd > /dev/null 2>&1) && echo "..okay."
##add a user
useradd -m "$auser"
echo -n "changing $auser password..."
((echo $apass; echo $apass) | passwd $auser > /dev/null 2>&1) && echo "..okay."

##create package directory
mkdir "$apkg"

##call functions for system gen
 aline
 if [ "$aauto" = "true" ]; then
 iauto
 fi
imods
prepboot
iboot
finboot
aline
ipacs
 if [ "$asplash" = "true" ]; then
 aline
 iplym
 fi
aline
iscreen
idaemon
aline
regen
 if [ "$pron" = "true" ]; then
 aline
 repac
 fi
 if [ "$fpon" = "true" ]; then
 aline
 iflats
 fi
aline
reman
aline
icrypt
##finish admin area
chown -R "$auser" "$aloc"
chmod -x $0

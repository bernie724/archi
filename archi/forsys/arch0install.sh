#!/bin/bash
##B.Thompson
##main installs after arch-chroot
if [ $UID -ne 0 ]; then
echo "run as root!"
exit 1
fi
##start stage 2 after chroot
idir=/usr/local/archi
cd "$idir"
source archi.conf
source logic/color
source logic/bootmisc
source logic/packmisc
source logic/regemisc
##time
msg " ${BOLD}$0 ${BGREEN}Starting...${CLS}"
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
if [ "$aauto" = "true" -a "$pbon" = "false" ]; then
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
idaemon
##install ssaver wallpaper
awm=$((which startxfce4 > /dev/null 2>&1 && echo true) || echo false)
if [ "$awm" = "true" ]; then
iscreen
fi
##acrypt, lock up the conf file on the live system
if [ "$acrypt" = "true" ]; then
aline
icrypt
else
rm "$idir/$aconf"
fi
##regenerate sys/user/linux
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
##finish admin area
chmod -x $0

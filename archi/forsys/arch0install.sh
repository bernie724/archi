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
echo -n "changing [$auser] password..."
((echo $apass; echo $apass) | passwd $auser > /dev/null 2>&1) && echo "..okay."
##create package directory
mkdir -p "$apkg"
##call functions for system gen
if [ "$aauto" = "true" -a "$pbon" = "false" ]; then
iauto
fi
imods
aline
prephost
prepboot
iboot
finboot
aline
iwin
ipacs
aline
if [ "$asplash" = "true" ]; then
iplym
fi
idaemon
##install ssaver wallpaper
iscreen
##acrypt, lock up the conf file on the live system
if [ "$acrypt" = "true" ]; then
aline
icrypt
else
rm "$idir/$aconf"
fi
##regenerate sys/user/linux
if [ "$fpon" = "true" ]; then
aline
iflats
if [ "$fpofficeon" = "true" ]; then
ioffice
fi
fi
aline
regen
reman
if [ -d "$ahome" ]; then
chown -R "$auser" "$ahome"
chown -R "$auser" "$aloc"
fi
chmod -x $0

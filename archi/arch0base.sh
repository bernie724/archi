#!/bin/bash
##B.Thompson
source archi.conf
source headfoot
clear
setfont "$afont"
basehead
aline
echo "Did you need to vim/nano archi.conf first.."
echo "$0 will DESTROY your entire [$rdev] disk!!!"
echo -n "$0 is for testing ONLY! Proceed [YES] "; read destroysystem
if [ "$destroysystem" = "YES" ]; then
aline
echo "Sys:[$osn] Host:[$ahost] User:[$auser] Pass:[$apass]"
echo "When complete make sure to change your boot order!"
aline

##complete wipe/format disk 1 [rdev]
if [ "$apdisk" = "true" ]; then
echo -n "Prepairing Disk [$rdev]"
chmod +x prepdisk.sh
./prepdisk.sh > /dev/null 2>&1
chmod -x prepdisk.sh
echo "...okay."
fdisk -l | grep "$rdev$bpar"
fdisk -l | grep "$rdev$rpar"
fi

##format first disk partitions
aline
echo -n "Formating partitions/swap..."
mkfs.fat -F 32 "$rdev$bpar" > /dev/null 2>&1
mkfs.ext4 -q -F "$rdev$rpar" > /dev/null 2>&1
mount "$rdev$rpar" "$rmnt" 
mount --mkdir "$rdev$bpar" "$rmnt/$bmnt" #/dev/sda1 /mnt/boot

##second disk
if [ "$bpdisk" = "true" ]; then
echo -n "Prepairing Disk [$bdisk]"
mkfs.ext4 -q -F "$bdisk" > /dev/null 2>&1
mount --mkdir "$bdisk" "$rmnt"/var/lib/flatpak && echo "..okay."
fdisk -l | grep "$bdisk"
fi

##swap
mkswap "$rdev$spar"  > /dev/null 2>&1
swapon "$rdev$spar"
echo "...okay."

##clock
aline
timedatectl | grep Universal | awk '{ print $3,$4,$5,$6 }'

##linux base
aline
echo "This will take a few minutes, get some coffee.."
echo -n "Installing linux [$rdev$rpar]..."
(pacstrap -K "$rmnt" base linux linux-firmware > /dev/null 2>&1) && echo ".okay."
genfstab -U "$rmnt" >> "$rmnt/etc/fstab"
aline
echo -n "Configure $osn..."
mkdir -p "$rmnt/$idir"
cp "$aconf" "$rmnt/$idir/"
mv "$rmnt/etc/skel" "$rmnt/etc/skel.arch"

##check spash screen true 
if [ "$asplash" = "true" ]; then
echo "plymouth" >> "forsys/$plist"
mv "$rmnt/etc/mkinitcpio.conf" "$rmnt/etc/mkinitcpio.conf.arch"
mv "$atool/mkinitcpio.conf.splash"  "$rmnt/etc/mkinitcpio.conf"
rm "$atool/mkinitcpio.conf.nosplash"
else
mv "$rmnt/etc/mkinitcpio.conf" "$rmnt/etc/mkinitcpio.conf.arch"
mv "$atool/mkinitcpio.conf.nosplash" "$rmnt/etc/mkinitcpio.conf"
rm "$atool/mkinitcpio.conf.splash"
fi

##arch-chroot prep
#cp "$atool/archi.jpg" "$rmt/$bmnt"
mv "$atool/litexfce.sh" "$rmnt/usr/local/bin/"
mv "$atool/darkxfce.sh" "$rmnt/usr/local/bin/"
mv "$atool/flatauto.sh" "$rmnt/usr/local/bin/"
cp readme.txt "$rmnt/$idir/"
if [ "$aauto" = "true" ]; then
mv "$atool/profile.auto" "$atool/".profile
rm "$atool/profile.noauto"
else
mv "$atool/profile.noauto" "$atool/".profile
rm "$atool/profile.auto"
fi
mv "$atool" "$rmnt/etc/"
cp -rp forsys/* "$rmnt/$idir/" 
echo ".okay."
aline
echo "$0 Finished..."

##handoff and finish the install in chroot sys
arch-chroot "$rmnt" "$idir"/arch0install.sh
##exit chroot

aline
basefoot

else
aline
echo "you're on your own..."
exit
fi

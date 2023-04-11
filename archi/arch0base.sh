#!/bin/bash
##B.Thompson
source archi.conf
source forsys/logic/color
source forsys/logic/headfoot
clear
setfont "$afont"
basehead
aline
echo "Did you need to vim/nano archi.conf first.."
msg "$0 will ${BRED}DESTROY${CLS} your entire [$rdev] disk!!!"
msgn "$0 is for ${YELLOW}testing ONLY!${CLS} Proceed [YES] ${RED}"; read destroysystem
if [ "$destroysystem" = "YES" ]; then
msgn ${CLS}
aline
msg "(archi.conf) Sys:${BOLD}[$osn] ${CLS}Host:${BOLD}[$ahost]${CLS} User:${BOLD}[$auser]${CLS} Pass:${BOLD}[$apass]${CLS}"
msg "${CYAN}When complete make sure to change your boot order!${CLS}"
aline
##complete wipe/format disk 1 [rdev]
if [ "$apdisk" = "true" ]; then
echo -n "Prepairing Disk [$rdev]"
chmod +x prepdisk.sh
./prepdisk.sh > /dev/null 2>&1
chmod -x prepdisk.sh
echo "...okay."
fi
##format first disk partitions
echo -n "Formating [$rdev] partitions & swap..."
if [ "$afs" = "ext4" -o "$afs" = "btrfs" ]; then
if [ "$afs" = "btrfs" ]; then
mkfs."$afs" -f -q "$rdev$rpar" > /dev/null 2>&1
fi
if [ "$afs" = "ext4" ]; then
mkfs."$afs" -F -q "$rdev$rpar" > /dev/null 2>&1
fi
else
echo "afs= must be ext4 or btrfs in $aconf"
exit 1
fi
mount "$rdev$rpar" "$rmnt"
##format boot partition
mkfs.fat -F 32 "$rdev$bpar" > /dev/null 2>&1
mount --mkdir "$rdev$bpar" "$rmnt/$bmnt" #/dev/sda1 /mnt/boot
##second disk
if [ "$bpdisk" = "true" ]; then
echo -n "Prepairing Disk [$bdev]"
mkfs.ext4 -q -F "$bdev" > /dev/null 2>&1
mount --mkdir "$bdev" "$rmnt"/var/lib/flatpak && echo "..okay."
fi
##swap
mkswap "$rdev$spar" > /dev/null 2>&1
swapon "$rdev$spar"
echo "...okay."
##clock
aline
timedatectl | grep Universal | awk '{ print $3,$4,$5,$6 }'
##linux base
msg "${BOLD}$0 will take a few minutes, brew some coffee..${CLS}"
echo -n "Installing linux [$rdev$rpar]..."
((pacstrap -K "$rmnt" base linux linux-firmware > /dev/null 2>&1) && echo ".okay.") || (msg "${RED}failed! this can't happen reboot the iso!${CLS}"; exit 1)
genfstab -U "$rmnt" >> "$rmnt/etc/fstab"
##customize local settings
echo -n "Configure $osn..."
mkdir -p "$rmnt/$idir" && echo -n "."
cp "$aconf" "$rmnt/$idir/" && echo -n "."
mv "$rmnt/etc/skel" "$rmnt/etc/skel.arch" && echo -n "."
##check spash screen true
if [ "$asplash" = "true" ]; then
echo "plymouth" >> "forsys/$plist"
mv "$rmnt/etc/mkinitcpio.conf" "$rmnt/etc/mkinitcpio.conf.arch"
mv "$atool/mkinitcpio.conf.splash" "$rmnt/etc/mkinitcpio.conf"
rm "$atool/mkinitcpio.conf.nosplash"
else
mv "$rmnt/etc/mkinitcpio.conf" "$rmnt/etc/mkinitcpio.conf.arch"
mv "$atool/mkinitcpio.conf.nosplash" "$rmnt/etc/mkinitcpio.conf"
rm "$atool/mkinitcpio.conf.splash"
fi
##arch-chroot prep
#cp "$atool/archi.jpg" "$rmt/$bmnt"
mv "$atool/litexfce.sh" "$rmnt/$aloc/bin/"
mv "$atool/darkxfce.sh" "$rmnt/$aloc/bin/"
mv "$atool/rmpacset.sh" "$rmnt/$aloc/bin/"
mv "$atool/flatiset.sh" "$rmnt/$aloc/bin/"
mv "$atool/alien.sh" "$rmnt/$aloc/bin/"
cp readme.txt "$rmnt/$idir/"
if [ "$aauto" = "true" -a "$pbon" = "false" ]; then
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
msgn "${BOLD}$0 ${CLS}Finished..."
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

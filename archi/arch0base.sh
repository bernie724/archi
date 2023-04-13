#!/bin/bash
##B.Thompson
source archi.conf
source forsys/logic/color
source forsys/logic/headfoot
clear
setfont "$afont"
if [ "$warn" = "true" ]; then
aline
basehead
echo "Did you need to vim/nano archi.conf first..."
msg "$0 will ${BRED}DESTROY${CLS} your entire [$rdev] disk"
msgn "$0 is for ${YELLOW}testing ONLY!${CLS} Proceed [YES] ${RED}"; read destroysystem
msgn "${CLS}"
else
destroysystem="YES"
fi
if [ "$destroysystem" = "YES" ]; then
msgn ${CLS}
aline
msg "(archi.conf) Sys:${BOLD}[$osn] ${CLS}Host:${BOLD}[$ahost]${CLS} User:${BOLD}[$auser]${CLS} Pass:${BOLD}[$apass]${CLS}"
msg "${CYAN}When complete make sure to change your boot order!${CLS}"
aline
##partition disk [rdev]
if [ "$apdisk" = "true" ]; then
echo -n "Prepairing Disk [$rdev].."
if [ "$apext" = "false" ]; then
swplus=$((bosize + swsize))
if [ $rosize -eq -1 ]; then
rosize=-2048s
else
rosize="$rosize""GiB"
fi
parted --script -a optimal -- "$rdev" mklabel gpt mkpart primary 1MiB "$bosize"GiB mkpart primary "$bosize"GiB "$swplus"GiB mkpart primary "$swplus"GiB "$rosize" 
else
##extended disk parts
hmnt=/home
fpmnt=/var/lib/flatpak
swplus=$((bosize + swsize))
hoplus=$((swplus + hosize))
fpplus=$((hoplus + fpsize))
if [ $rosize -eq -1 ]; then
rosize=-2048s
else
rosize="$rosize""GiB"
fi
parted --script -a optimal -- "$rdev" mklabel gpt mkpart primary 1MiB "$bosize"GiB mkpart primary "$bosize"GiB "$swplus"GiB mkpart primary "$swplus"GiB "$hoplus"GiB mkpart primary "$hoplus"GiB "$fpplus"GiB mkpart primary "$fpplus"GiB "$rosize"  
fi
echo ".okay."
fi

echo -n "Formating partitions & swap [$rdev].."
##format disk partitions
if [ "$afs" = "ext4" -o "$afs" = "btrfs" ]; then
if [ "$apext" = "false" ]; then
if [ "$afs" = "btrfs" ]; then
mkfs."$afs" -f -q "$rdev$rpar" > /dev/null 2>&1
mount "$rdev$rpar" "$rmnt"
fi
if [ "$afs" = "ext4" ]; then
mkfs."$afs" -F -q "$rdev$rpar" > /dev/null 2>&1
mount "$rdev$rpar" "$rmnt"
fi
else
if [ "$afs" = "btrfs" ]; then
mkfs."$afs" -f -q "$rdev$rpar" > /dev/null 2>&1
mkfs."$afs" -f -q "$rdev$hpar" > /dev/null 2>&1
mkfs."$afs" -f -q "$rdev$fppar" > /dev/null 2>&1
mount "$rdev$rpar" "$rmnt"
fi
if [ "$afs" = "ext4" ]; then
mkfs."$afs" -F -q "$rdev$rpar" > /dev/null 2>&1
mkfs."$afs" -F -q "$rdev$hpar" > /dev/null 2>&1
mkfs."$afs" -F -q "$rdev$fppar" > /dev/null 2>&1
mount "$rdev$rpar" "$rmnt"
fi
fi
else
echo "afs= must be ext4 or btrfs in $aconf"
exit 1
fi

##format boot partition
mkfs.fat -F 32 "$rdev$bpar" > /dev/null 2>&1
mount --mkdir "$rdev$bpar" "$rmnt/$bmnt" #/dev/sda1 /mnt/boot
##swap
mkswap "$rdev$spar" > /dev/null 2>&1
swapon "$rdev$spar"
echo ".okay."
##clock
aline
timedatectl | grep Universal | awk '{ print $3,$4,$5,$6 }'
##linux base
msg "${BOLD}$0 will take a few minutes, brew some coffee..${CLS}"
echo -n "Installing linux [$rdev$rpar].."
((pacstrap -K "$rmnt" base linux linux-firmware > /dev/null 2>&1) && echo ".okay.") || (msg "${RED}failed! this can't happen reboot the iso!${CLS}"; exit 1)
if [ "$apext" = "true" ]; then
echo -n "Mounting [$hmnt] & [$fpmnt].."
mount "$rdev$hpar" "$rmnt/$hmnt" && echo -n "."
mount --mkdir "$rdev$fppar" "$rmnt/$fpmnt" && echo -n "."
echo ".okay."
fi
echo -n "configuring fstab.."
genfstab -U "$rmnt" >> "$rmnt/etc/fstab" && echo -n "."
echo ".okay."

##customize local settings
echo -n "Configure [$osn].."
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
mv "$atool/litexfce.sh" "$rmnt/$aloc/bin/"
mv "$atool/darkxfce.sh" "$rmnt/$aloc/bin/"
mv "$atool/rmpacset.sh" "$rmnt/$aloc/bin/"
mv "$atool/flatiset.sh" "$rmnt/$aloc/bin/"
mv "$atool/alien.sh" "$rmnt/$aloc/bin/"
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
umountall
basefoot
else
aline
msg "${CLS}you're on your own..."
exit
fi

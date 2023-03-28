#!/bin/bash
source archi.conf
echo
aline
echo "read: https://wiki.archlinux.org/title/installation_guide"
echo "run $0 after you have partition your disk."
aline
echo "$0 starts @ section 1.10 of the installation_guide"
aline
echo "When these set of scripts are complete, this machine will" 
echo "be a powerful Arch [$osn] system; ready for $thisy and beyond!"
echo "Goal: A clean, quick, nimble and progressive desktop."
echo "Reasonable package (pacman) use for base/core/modern operations,"
echo "flatpak for userspace and desktop apps when avialable."
aline
echo "$0 can clobber the entire disk!"
echo -n "$osn is for testing ONLY! Proceed [Y/N] "; read destroysystem
if [ "$destroysystem" = "Y" ]; then
#clock
aline
timedatectl
mkfs.fat -F 32 "$rdev$bpar" > /dev/null 2>&1
mkfs.ext4 -q -F "$rdev$rpar" > /dev/null 2>&1
mount "$rdev$rpar" "$rmnt" 
mount --mkdir "$rdev$bpar" "$rmnt/$bmnt" #/dev/sda1 /mnt/boot
if [ "$paksdb" = "true" ]; then
mkfs.ext4 -q -F /dev/sdb1 > /dev/null 2>&1
mount --mkdir /dev/sdb1 /mnt/var/lib/flatpak
fi
mkswap "$rdev$spar"  > /dev/null 2>&1
swapon "$rdev$spar"
aline
echo "This will take several minutes, get some coffee.."
aline
echo -n "Install base..."
(pacstrap -K "$rmnt" base linux linux-firmware > /dev/null 2>&1) && echo ".done!"
genfstab -U "$rmnt" >> "$rmnt/etc/fstab"
aline
echo "copying scripts to the os directory [$aloc]"
mkdir "$rmnt/$aloc/$osn"
mkdir "$rmnt/$ddir"
cp "$aconf" "$rmnt/$aloc/$osn/"
mv "$rmnt/etc/skel" "$rmnt/etc/skel.arch"
mv "$rmnt/etc/profile" "$rmnt/etc/profile.arch"
mv "$rmnt/etc/bash.bashrc" "$rmnt/etc/bash.bashrc.arch"
mv forsys/skel/profile "$rmnt/etc/"
mv forsys/skel/bash.bashrc "$rmnt/etc/"
mv forsys/skel "$rmnt/etc/"
cp forsys/* "$rmnt/$aloc/$osn/" 
#scp -r "$auser@$asyst:$aloc/$aint/$tarb" "$rmnt/$aloc/$aint/" 
#cd "$rmnt/$aloc/" && tar xzpf "$tarb" || exit 1
cd
aline
echo "Next Step:"
echo "cd $aloc/$osn; ./arch1core.sh"
aline
arch-chroot "$rmnt"
else
echo "you're on your own..."
exit
fi

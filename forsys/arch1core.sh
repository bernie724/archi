#!/bin/bash
##B. Thompson
#within arch-chroot /mnt i.e. /mnt is / [root]
if [ $UID -ne 0 ]; then
echo "run as root!"
exit 1
fi
source archi.conf 
##time
ln -sf /usr/share/zoneinfo/"$ltime" /etc/localtime
hwclock --systohc
##banner
echo "$osb" > /etc/issue
##keyboard&lang
echo "$lang $code" >> /etc/locale.gen
locale-gen
echo "LANG=$lang" > /etc/locale.conf
echo "KEYMAP=$keym" > /etc/vconsole.conf
echo "FONT=ter-724n" >> /etc/vconsole.conf
echo "$hostn" > /etc/hostname
##change root pass
aline
echo "change root passwd"
aline
passwd
##add a user
useradd -m "$auser"
aline
echo "change $auser passwd"
aline
passwd "$auser"
aline
##boot loader and strap
echo -n "Installing git..."
(pacman -Sy --needed --color always --noconfirm --noprogressbar base-devel git > /dev/null 2>&1) && echo ".done!"
##change /etc/sudoers to include $USERNAME i.e. you
echo "$auser ALL=NOPASSWD: ALL" >> /etc/sudoers ##this makes sure uid 1000 doesnt use a password for sudo
##Build bootloader## I have a long history of grub hating me, so I use limine for these tests.
mkdir "$pdir"
cd "$pdir" || exit 1
echo -n "get $bapp boot/loader/strap..."
(git clone https://aur.archlinux.org/$bapp.git > /dev/null 2>&1) && echo ".done!"
#git clone https://aur.archlinux.org/limine.git
chown -R "$auser" "$aloc"
cd $bapp
#echo "Sometimes makepkg sticks hit Enter Twice:"
#echo "@ 'Updating the info directory file..'"
aline
echo -n "build/install $bapp..."
(su $auser -c "makepkg -si --noconfirm" > /dev/null 2>&1) && echo ".done!"
cp /usr/share/limine/limine.sys /boot/
limine-deploy "$rdev" 2> /dev/null
ruuid=$(blkid -s UUID -o value "$rdev$rpar")
echo 'TIMEOUT=5
:'"$osn"'
    PROTOCOL=linux
    KERNEL_PATH=boot:///vmlinuz-linux
    CMDLINE=root=UUID='"$ruuid"' rw loglevel=3 quiet
    MODULE_PATH=boot:///initramfs-linux.img' > /opt/limine.cfg
cp /opt/limine.cfg /boot/
##packages pacman
cd $aloc/$osn
aline
echo "Setup: core, bin, net, wm, extras [this will take a bit]"
aline
numpak=$(cat arch1.set | wc -l)
while read set; do
echo -n "[$numpak] Installing $set..."
(pacman -Sy --color always --noconfirm --noprogressbar "$set" > /dev/null 2>&1) && echo ".done!"
let numpak--
done < arch1.set
echo -n "Add flatpak repo [flathub]..."
(flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo > /dev/null 2>&1) && echo ".done!"
aline
ln -s /usr/bin/vim /usr/bin/vi
echo -n "Enable daemons, services.." 
(systemctl enable NetworkManager > /dev/null 2>&1) && echo -n ".."
(systemctl enable dhcpcd.service > /dev/null 2>&1) && echo -n ".."
(systemctl enable sshd > /dev/null 2>&1) && echo -n ".."
(systemctl enable ntpd > /dev/null 2>&1) && echo -n ".."
(systemctl enable cups > /dev/null 2>&1) && echo -n ".."
(systemctl enable avahi-daemon > /dev/null 2>&1) && echo -n ".."
(systemctl enable paccache.timer > /dev/null 2>&1) && echo -n ".."
hwclock -w && echo -n ".."
echo "...done!"
aline
##regen
echo -n "regen linux..."
(mkinitcpio -p linux > /dev/null 2>&1) && echo ".done!"
aline
echo "To complete the install [$osn]:" > /etc/motd
echo "cd $aloc/$aint; ./arch2main.sh" >> /etc/motd
echo "Reboot, [F12] or select 'Boot existing OS'"
echo "login $auser, cd $aloc/$aint; ./arch2main.sh"
aline
echo "[ctrl-d]; reboot #NOW!"
aline

#!/bin/bash
#for Intel:
if [ $UID -eq 0 ]; then
echo "DO NOT run as root!"
exit 1
fi
source archi.conf
if [ -f /etc/motd ]; then
sudo rm /etc/motd
fi

echo -n "copy $auser ssh keys [Y/N] "; read sskey
if [ "$sskey" = "Y" ]; then
scp -rp "$scphost":~/.ssh ~/
fi
echo -n "Removing some overlap [gnome-keyring, etc]..."
(sudo pacman -R --color always --noconfirm guvcview parole xdg-desktop-portal-gnome gnome-keyring  > /dev/null 2>&1) && echo ".done!"
aline
echo "Installing packages [flatpak] this will take a while.."
aline
numpak=$(cat flat1.set | wc -l)
while read set; do 
echo -n "[$numpak] Installing $set..."
#(sudo pacman -Sy --color always --noconfirm --noprogressbar "$set" > /dev/null 2>&1) && echo -n ".."
(sudo flatpak install -y "$set" > /dev/null 2>&1) && echo ".done!"
let numpak--
done < flat1.set 
aline
flatpak list
aline
##web
touch ~/.xinitrc
touch ~/.Xauthority
##update man pages
echo -n "Updating man pages..."
sudo mandb -q 2> /tmp/man$$.err
echo "...Done!"
#sudo pacman -Syyu
aline
##Pro
echo -n "Update luks crypt"
sudo modprobe dm-crypt
sudo modprobe dm-mod
echo "...done!"
clear
aline
echo "$osn is done!"
echo "Use 'flatpak search <term>' to find more apps."
aline
echo "Change themes from a xfce4-terminal with: "
echo "xfcedark.sh xfcelite.sh"
aline
echo -n "Enjoy! -bt "
##sleep and spin
x=0
stime=15
spin='-\|/'
max=$(( $stime * 10 ))
pd=' '
while [ $x -le $max ]
do
  x=$(( $x + 1 ))
if [ $x -le $max ]
then
 i=$(( (i+1) %4 ))
  echo -ne "\b${spin:$i:1}"
else
echo -ne "\b$pd"
fi
sleep .10
done
echo
(exec startxfce4 2> /dev/null)
reset; clear; exit

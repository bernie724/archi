#!/bin/bash
##B.Thompson
##mini archi install wrapper, log and reboot
source archi.conf
source forsys/logic/headfoot
source forsys/logic/color
areboot=true
if [ "$warn" = "false" ]; then
clear
setfont "$afont"
pacmc=$(cat forsys/"$plist" | wc -l)
if [ "$fpon" = "true" ]; then
flakc=$(cat forsys/"$flist" | wc -l)
else
flakc="n/a"
fi
date
echo "$0: System will reboot after install."
aline
echo "Change boot order if needed."
echo "After reboot the log will be $idir/archi.$$.log"
aline
echo "[$pacmc] pacman packages, [$flakc] flatpak apps."
echo -n "Installing system..."
./arch0base.sh > ~/archi.$$.log 2>&1
echo ".okay."
mount "$rdev$rpar" "$rmnt"
cp ~/archi.$$.log "$rmnt"/"$idir"
umount "$rmnt"
sleep .5
basefoot
else
echo "$0 is a arch0base.sh wrapper that installs and reboots without warnings"
echo "warn= 'must be false' for $0"
echo "vim $aconf"
fi

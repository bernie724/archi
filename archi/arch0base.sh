#!/bin/bash
##B.Thompson
source archi.conf
source forsys/logic/color
source forsys/logic/headfoot
source forsys/logic/diskmisc
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
diskpart
formatroot
formatboot
formatswap
ilinux
##customize local settings
echo -n "Setup install area [$osn].."
mkdir -p "$rmnt/$idir" && echo -n "."
cp "$aconf" "$rmnt/$idir/" && echo -n "."
cp -rp forsys/* "$rmnt/$idir/" && echo -n "."
echo ".okay."
aline
##handoff and finish the install in chroot sys
msgn "${BOLD}$0 ${CLS}Finished..."
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

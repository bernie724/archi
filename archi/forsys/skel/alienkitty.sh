#!/bin/bash
##B.Thompson
##if you need aliens (aur) use this script
##e.g. $ aursi.sh google-cloud-cli #that's it
aapp="$1"
aurl="https://aur.archlinux.org/"
apkg=/usr/local/packages
auser=$USERNAME
##functions recent & top50

aurup () {
lynx -dump -dont_wrap_pre -list_inline -accept_all_cookies https://aur.archlinux.org | grep /packages/ | rev | cut -d/ -f1 | rev | grep ^[a-Z] | cut -d] -f1
}
aurpop () {
lynx -dump -dont_wrap_pre -list_inline -accept_all_cookies https://aur.archlinux.org/packages | grep /packages/ | rev | cut -d/ -f1 | rev | grep ^[a-Z] | cut -d] -f1
}
if [ "$aapp" = "nifty" ]; then
aurpop
exit
fi
if [ "$aapp" = "recent" ]; then
aurup
exit
fi
if [ "$aapp" = "aliens" ]; then
pacman -Qm
exit
fi
if [ -z "$aapp" ]; then
aurup
echo -n "aur to install: "; read aapp;
fi
set +x 

##Build/install aur 
if [ -n "$aapp" -a -d "$apkg" ]; then
aurup
echo -n "Cloning $aapp..."
cd "$apkg"
((git clone "$aurl/$aapp".git > /dev/null 2>&1) && echo ".okay.") || (echo "package $aapp doesnt exist"; exit 1)
else
echo "Usage: $0 <aurpac>"
echo "Usage: $0 [nifty]/[recent]/[aliens]"
echo "recent=recent 15; nifty=top 50;aliens=list installed aurs"
exit 1
fi

if [ -d "$apkg/$aapp" ]; then
echo -n "Build/Install $aapp..."
cd "$apkg/$aapp"
chown -R "$auser" "$apkg/$aapp"
((makepkg -si --noconfirm > /dev/null 2>&1) && echo ".okay.") || (echo "error installing $aapp; try manual install"; exit 1)
else
echo "Usage: $0 <aurpac> [check the clone]"
exit 1
fi

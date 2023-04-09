#!/bin/bash
##B.Thompson
##if you need aliens (aur) use this script, forget octipi or yay, just use this (-: or not
##e.g. $ aursi.sh google-cloud-cli #that's it
aapp="$1"
aurl="https://aur.archlinux.org/"
apkg=/usr/local/packages
auser=$USERNAME

##Build/install aur 
if [ -n "$aapp" -a -d "$apkg" ]; then
echo -n "Cloning $aapp..."
cd "$apkg"
((git clone "$aurl/$aapp".git > /dev/null 2>&1) && echo ".okay.") || (echo "package $aapp doesnt exist"; exit 1)
else
echo "Usage: $0 <aurpac>"
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

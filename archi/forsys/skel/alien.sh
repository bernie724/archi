#!/bin/bash
##B.Thompson
##if you need aliens (aur) use this script
comm="$1"
aapp="$2"
term="$2+$3+$4"
setfile="$2"
aurl="https://aur.archlinux.org/"
apkg=/usr/local/packages
aset=/usr/local/archi/sets/exp
auser=$USERNAME
 if [ "$comm" = "search" -o "$comm" = "install" -o "$comm" = "list" -o "$comm" = "batch" -o "$comm" = "aliens" ]; then
sudo chown -R "$auser" "$apkg"
##functions recent & top50
aurup () {
lynx -dump -dont_wrap_pre -list_inline -accept_all_cookies https://aur.archlinux.org | grep /packages/ | rev | cut -d/ -f1 | rev | grep ^[a-Z] | cut -d] -f1
}
aurpop () {
lynx -dump -dont_wrap_pre -list_inline -accept_all_cookies https://aur.archlinux.org/packages | grep /packages/ | rev | cut -d/ -f1 | rev | grep ^[a-Z] | cut -d] -f1
}

aursearch () {
lynx -dump -dont_wrap_pre -list_inline -accept_all_cookies 'https://aur.archlinux.org/packages?O=0&K='"$term"'' | grep /packages/ | rev | cut -d/ -f1 | rev | grep ^[a-Z] | cut -d] -f1
}

##Build/install aur 

aurbuild () {
echo -n "Cloning $aapp..."
cd "$apkg"
((git clone "$aurl/$aapp".git > /dev/null 2>&1) && echo ".okay.") || (echo "package $aapp doesnt exist"; exit 1)
}

aurinstall () {
echo -n "Build/Install $aapp..."
cd "$apkg/$aapp"
#chown -R "$auser" "$apkg/$aapp"
((makepkg -si --noconfirm > /dev/null 2> /tmp/makepkg.err) && echo ".okay.") || (echo ".failed." ; cat /tmp/makepkg.err | grep ^[eE]rror;  echo "Errors installing $apkg/$aapp; try manual install"; exit)
}

aurbatch () {
if [ -f "$aset/$setfile" ]; then
echo "running: $setfile"
else
echo "$0 installs aur packages from a batch list"
echo "Usage: $0 batch <aursetname.set>"
echo "$aset:"
ls "$aset"
exit 1
fi
while read aapp; do
if [ -d "$apkg/$aapp" ]; then
rm -r "$apkg/$aapp"
fi
aurbuild
aurinstall
echo
done < "$aset/$setfile"
}

if [ "$comm" = "batch" ]; then
aurbatch
fi

if [ "$comm" = "search" ]; then
aursearch
exit
fi

if [ "$comm" = "install" ]; then
if [ -n "$aapp" -a -d "$apkg" -a ! -d "$apkg/$aapp" ]; then
aurbuild
taur=$(ls -1 "$apkg/$aapp")
if [ -z "$taur" ]; then
rm -r "$apkg/$aapp"
echo "$aapp is not an aur"
fi
fi
if [ -d "$apkg/$aapp" -a -n "$aapp" ]; then
aurinstall
fi
exit
fi

if [ "$comm" = "list" -a "$aapp" = "top50" ]; then
aurpop
exit
fi

if [ "$comm" = "list" -a "$aapp" = "recent" ]; then
aurup
exit
fi

if [ "$comm" = "aliens" ]; then
pacman -Qm
exit
fi
 else
echo "Usage: $0 search <term>"
echo "Usage: $0 install <aurpac>"
echo "Usage: $0 batch <aursetname.set>"
echo "Usage: $0 list [top50]/[recent]"
exit 1
 fi


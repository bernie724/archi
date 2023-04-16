#!/bin/bash
##B.Thompson
##Runs a flatpak app by short name
app="$1"
daemon=true ##true background run app
appuse () {
echo "::Run a flatpak app by the apps shortname::"
echo "Usage: $0 <shortnameApp>"
echo "::List available apps::"
echo "Usage: $0 [list]"
exit 1
}
#variables
apptmp=/tmp/.app$$.tmp
appr=$(echo "$app" | rev)
appidtest=$(flatpak list --columns=application | cut -d\. -f3 | grep ^"$app") 

#functions
apprun () {
echo "Running: $appid "
if [ "$daemon" = "true" ]; then
(flatpak run "$appid" &) > /dev/null 2>&1
else
flatpak run "$appid"
fi
exit
}

applist () {
flatpak list --columns=application | cut -d\. -f3 | sort -u | grep -v 'default\|openh264\|Platform' > "$apptmp"
echo -n "Available apps: "
while read file; do
echo -n "$file,"
done < "$apptmp" 
echo -ne "\b "
rm "$apptmp"
echo
exit
}

#conditions
if [ -n "$app" -a -n "$appidtest" -a "$app" != "list" ]; then
appid=$(flatpak list --columns=application | rev | grep ^"$appr" | rev)
apprun 
elif [ "$app" = "list" ]; then
applist
else
if [ -z "$appitest" -a -n "$app" ]; then
echo "[$app not installed]"
applist
else
appuse
fi
fi

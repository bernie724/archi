#!/bin/bash
app="$1"
appterm="$2"
daemon=true ##true background run app
appuse () {
echo "::Search available apps::"
echo "Usage: $0 [search] <term>"
echo "::Install a flatpak app by the apps shortname::"
echo "Usage: $0 <shortnameApp>"
exit 1
}

apptmp=/tmp/.app$$.tmp
appr=$(echo "$app" | rev)
appid=$(flatpak search "$appterm" --columns=application | rev | grep ^"$appr" | rev)

apprun () {
echo "Running: $appid "
if [ "$daemon" = "true" ]; then
(flatpak run "$appid" &) > /dev/null 2>&1
else
flatpak run "$appid"
fi
exit
}

appsearch () {
flatpak search --columns=application | rev | cut -d\. -f1 | rev | sort -u > "$apptmp" 
echo -n "Available apps: "
while read file; do
echo -n "$file,"
done < "$apptmp" 
echo -ne "\b "
rm "$apptmp"
echo
exit
}

if [ -n "$appid" -a -n "$app" ]; then
apprun || (echo "$0 $app is not an available flatpak application"; applist)
elif [ "$app" = "search" ]; then
applist
else
appuse
fi

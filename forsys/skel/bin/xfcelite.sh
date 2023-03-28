#!/bin/bash
##basic xfce desktop
xtty=$(tty | grep tty | head -1)
if [ -n "$xtty" -o $UID -eq 0 ]; then
echo "run $0 in a xfce terminal and NOT as root!"
exit 1
fi
echo -n "$0 will reset xfce4 [y/n] "; read resetx
if [ "$resetx" = "y" ]; then
echo -n "$0 configuring xfce4..."
xfconf-query -c xfce4-panel -p /panels -t int -s 1 -a 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual-1/workspace0/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/ondasblue.jpg 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual-1/workspace1/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/park.jpg 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual-1/workspace2/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/park.jpg 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/monitorVirtual-1/workspace3/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/alone.jpg 2> /dev/null
xfconf-query -c xfwm4 -p /general/double_click_action -n -t 'string' -s 'shade' 2> /dev/null
xfconf-query -c xfwm4 -p /general/workspace_count -n -t 'int' -s '2' 2> /dev/null
xfconf-query -c xsettings -p /Net/ThemeName -n -t 'string' -s 'Adwaita' 2> /dev/null
xfconf-query -c xsettings -p /Net/IconThemeName -n -t 'string' -s 'elementary' 2> /dev/null
xfconf-query -c xsettings -p /Gtk/FontName -n -t 'string' -s "Serif Bold 10" 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/dark-mode -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/leave-opacity -n -t 'int' -s '95' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/enter-opacity -n -t 'int' -s '90' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/single-click -n -t 'bool' -s 'true' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/gravity -n -t 'int' -s '7' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/show-tooltips -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/icon-size -n -t 'int' -s '30' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -n -t 'bool' -s 'true' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/position -n -t 'string' -s 'p=6;x=0;y=0' 2> /dev/null
(xfce4-panel -r && xfwm4 --replace > /dev/null 2>&1) &
sleep .5
echo "...done!"
#aterms=$(pgrep --newest xfce4-terminal)
#kill $aterms
fi


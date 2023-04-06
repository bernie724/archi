#!/bin/bash
##basic xfce desktop
mon1="monitorVirtual-1"
xtty=$(tty | grep tty | head -1)
echo -n "$0 will reset xfce4 [y/n] "; read -n1 resetx
if [ "$resetx" = "y" ]; then
echo
echo -n "$0 configuring xfce4..."
#xfconf-query -c xfce4-panel -p /panels -t int -s 1 -a 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/single-workspace-mode -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/"$mon1"/workspace0/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/Aquarius.svg 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/"$mon1"/workspace1/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/paltanen.jpg 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/"$mon1"/workspace2/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/Klivia.jpg 2> /dev/null
xfconf-query -c xfce4-desktop -p /backdrop/screen0/"$mon1"/workspace3/last-image -n -t 'string' -s /usr/share/backgrounds/xfce/alone.jpg 2> /dev/null
xfconf-query -c xfwm4 -p /general/double_click_action -n -t 'string' -s 'shade' 2> /dev/null
xfconf-query -c xfwm4 -p /general/workspace_count -n -t 'int' -s '4' 2> /dev/null
xfconf-query -c xsettings -p /Gtk/FontName -n -t 'string' -s "URW Gothic 10" 2> /dev/null
xfconf-query -c xsettings -p /Net/ThemeName -n -t 'string' -s 'Adwaita-dark' 2> /dev/null
xfconf-query -c xsettings -p /Net/IconThemeName -n -t 'string' -s 'breeze-dark' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/dark-mode -n -t 'bool' -s 'true' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/leave-opacity -n -t 'int' -s '75' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/enter-opacity -n -t 'int' -s '80' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/position-locked -n -t 'bool' -s 'true' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/gravity -n -t 'int' -s '0' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/single-click -n -t 'bool' -s 'true' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/icon-size -n -t 'int' -s '30' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/show-tooltips -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-home -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-filesystem -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-trash -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-desktop -p /desktop-icons/file-icons/show-removable -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-panel -p /panels/panel-1/position -n -t 'string' -s 'p=8;x=0;y=0' 2> /dev/null
xfconf-query -c xfwm4 -p /general/frame_opacity -n -t 'int' -s '65' 2> /dev/null
xfconf-query -c xfwm4 -p /general/inactive_opacity -n -t 'int' -s '85' 2> /dev/null
xfconf-query -c xfwm4 -p /general/move_opacity -n -t 'int' -s '90' 2> /dev/null
xfconf-query -c xfwm4 -p /general/move_opacity -n -t 'int' -s '75' 2> /dev/null
xfconf-query -c xfwm4 -p /general/resize_opacity -n -t 'int' -s '70' 2> /dev/null
xfconf-query -c xfwm4 -p /general/theme -n -t 'string' -s 'Wallis' 2> /dev/null
xfconf-query -c xfwm4 -p /general/button_layout -n -t 'string' -s 'OS|HMC' 2> /dev/null
xfconf-query -c xfce4-panel -p /plugins/plugin-2/middle-click -n -t 'int' -s '1' 2> /dev/null
xfconf-query -c xfce4-panel -p /plugins/plugin-2/grouping -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-panel -p /plugins/plugin-2/show-labels -n -t 'bool' -s 'false' 2> /dev/null
xfconf-query -c xfce4-panel -p /plugins/plugin-2/show-tooltip -n -t 'bool' -s 'false' 2> /dev/null

if [ -z "$xtty" ]; then
(xfce4-panel -r && xfwm4 --replace > /dev/null 2>&1) &
sleep .5
fi
echo "...done!"
##kill for terms
aterms=$(pgrep --newest xfce4-terminal)
kill $aterms
fi


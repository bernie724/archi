# /etc/profile
# Set our umask
umask 022
# Set alias for flatpak
alias flat="flatpak"
# Append "$1" to $PATH when not already in.
# This function API is accessible to scripts in /etc/profile.d
append_path () {
    case ":$PATH:" in
        *:"$1":*)
            ;;
        *)
            PATH="${PATH:+$PATH:}$1"
    esac
}
# Append our default paths
append_path '/usr/local/sbin'
append_path '/usr/local/bin'
append_path '/usr/bin'
append_path '~/bin'
# Force PATH to be environment
export PATH
# Load profiles from /etc/profile.d
if test -d /etc/profile.d/; then
	for profile in /etc/profile.d/*.sh; do
		test -r "$profile" && . "$profile"
	done
	unset profile
fi
# Unload our profile API functions
unset -f append_path
# Source global bash config, when interactive but not posix or sh mode
if test "$BASH" &&\
   test "$PS1" &&\
   test -z "$POSIXLY_CORRECT" &&\
   test "${0#-}" != sh &&\
   test -r /etc/bash.bashrc
then
	. /etc/bash.bashrc
fi
# Termcap is outdated, old, and crusty, kill it.
unset TERMCAP
# Man is much better than us at figuring this out
unset MANPATH

## archi [v2023] nuIX (os724) [xiNn-hzLs0]

if [ -f ~/.nogoog ]; then
echo "Install stragglers..."
sudo flatpak install --noninteractive -y app/com.google.Chrome/x86_64/stable && rm ~/.nogoog
fi

hexist=$(which htop 2> /dev/null)
xexist=$(which startxfce4 2> /dev/null)
 if [ $UID -ne 0 ]; then

  if [ -n "$xexist" ]; then
echo -n "Start Graphical Environment [Y/n] "; read -n1 guis; echo
   if [ "$guis" = "N" -o "$guis" = "n" ]; then
myt=$(tty)
echo "pid: $$ tty: $myt"
   else
echo "Use: litexfce.sh or darkxfce.sh to switch themes!"
exec startxfce4 2> /dev/null
exit
   fi
  fi
 fi

 if [ -n "$hexist" ]; then
echo -n "Start Process Display (htop) [y/N] "; read -n1 tops; echo
  if [ "$tops" = "Y" -o "$tops" = "y" ]; then
htop
neofetch
  fi
 fi

if [ $UID -ne 0 ]; then
alias ls="ls --color=auto"
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "
fi

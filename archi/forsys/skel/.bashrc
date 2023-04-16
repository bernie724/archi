#
# /etc/bash.bashrc
#
# If not running interactively, don't do anything
[[ $- != *i* ]] && return
[[ $DISPLAY ]] && shopt -s checkwinsize
PS1='[\u@\h \W]\$ '
case ${TERM} in
Eterm*|alacritty*|aterm*|foot*|gnome*|konsole*|kterm*|putty*|rxvt*|tmux*|xterm*)
PROMPT_COMMAND+=('printf "\033]0;%s@%s:%s\007" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
;;
screen*)
PROMPT_COMMAND+=('printf "\033_%s@%s:%s\033\\" "${USER}" "${HOSTNAME%%.*}" "${PWD/#$HOME/\~}"')
;;
esac
if [[ -r /usr/share/bash-completion/bash_completion ]]; then
. /usr/share/bash-completion/bash_completion
fi
if [ $UID -ne 0 ]; then
alias ls="ls --color=auto"
alias flat="flatpak"
alias flath="flatpak --help"
alias flatr="flatpak run"
alias flatl="flatpak list"
alias flats="flatpak search"
alias flati="sudo flatpak install"
alias flatu="sudo flatpak uninstall"
alias pacsyu="sudo pacman -Syu --noconfirm" #upgrade all out of date
alias pacqu="pacman -Qu" #query needs update
alias pacqm="pacman -Qm" #query alien (aur) repo installs
alias pacqn="pacman -Qn" #query native (arch) repo installs
alias pacqs="pacman -Qs" #query package [name]
alias crypte="ccrypt -e"
alias cryptd="ccrypt -d"
alias cryptk="ccrypt -k"
alias cryptc="ccrypt -c"
PS1="\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$ "
fi

# archi
A set of scripts to automate the installation of Arch Linux as a desktop system.
make sure to read: https://wiki.archlinux.org/title/installation_guide
These are for my personal testing and use, as I am moving my desktop to Arch.
These scripts will **blowup** your system or virual machine.
**Only use these scripts for testing and fun!!!**
Start: Boot the Arch Linux iso [VM recommended]
These scripts should be a tarball somewhere [archi.tgz] 
scp to ~/ [/root] after you boot Arch install iso.
e.g. scp username@10.0.0.1:/tmp/archi.tgz
Make sure your harddrive is setup as 3 partitions sda1 sda2 sda3
[then] tar xf archi.tgz; cd archi
The install goes in 3 stages
stage 1: arch0base.sh #this is format/base/sanity
stage 2: arch1core.sh #this is after arch-chroot, bootloader/pacman core
stage 3: arch2main.sh #this is after reboot, user installed main/desktop/flatpak 
To start run
./arch0base.sh
follow the end dialog for the next step...

My goal is to have a clean, snappy (pun) Arch desktop that is light on core
and uses flatpak when available and sane.
I like to look forward and find the nice things that are happening in tech.
For my desktop I like futuristic not modern, what ever happened to beryl.. (-:
If you use, test or try these scripts.  Thank You.
Any feedback, fixes, improvements, whatnot would be nice.
-BT [3/28/2023]
ps there is the SuperDeluxDiskMangler.sh for the brave or crazy that [tries] setups the /dev/sda

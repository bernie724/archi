##Archi
##B.Thompson
WARNING: Do not run these scripts anywhere but on a booted Arch Linux Install ISO.
	 These scripts can oblitorate any system with root access.

This tarball is 1 commands that fully automates the install of Arch 
Linux, creating a fully opertional GUI Desktop System.

Again: These scripts are only for testing, fun and my own personal use.
I am not with Arch Linux or Flatpak in any capacity.

Goal:
Move away from all distro package managers on all Desktop (GUI) systems.
 [YaST, yum, make world, make build, make install, apt-get, dpkg, rpm, on and on
 you name it I have used it.  I am done with that.]

Plan:
Use Arch Linux for the system's foundation and flatpak for the Desktop and apps,
resulting in tight rolling managment of core and a disintrested flatpak apps arena. 

Pre:
Before config/run, you need to scp the archi.tgz to a booted Arch Install ISO and unpack.
From the ISO root (#):
e.g.
scp user@10.0.3.1:/tmp/archi.tgz .
tar xpzf archi.tgz
All my tests and scripting was on VirtualBox.  I plan (for myself) to try it on
some old hardware next, and then my actual systems currently running a varity of messy linux.

Configuring the scripts:
I would leave the settings for the first run, these scripts dont have a lot of checks yet...
config: archi.conf, 
e.g. vim/nano archi.conf to suit your install. default: user archi pass archi

Installing from the scripts.
The install goes in 1 command 2 stages.
stage 1: arch0base.sh    #this is format/base/sanity
stage 2: arch0install.sh #this is run in arch-chroot env installing boot/core/apps
There is NO interaction.

Start:
To start run from the unpacked archi.tgz archi/ directory
cd archi/; ./arch0base.sh

When complete the total system is installed, with all included flatpaks and a Desktop GUI (xfce4)
The flatpak and pacman list can be change to include or remove packages to the install
The package lists are located in archi/forsys/sets

Recommended:
Virtual Box VM
30 GiB default harddrive (uses 15G (current) complete) expecting /dev/sda
1 to 4 logical cpu(s)
1 to 4 GiB ram
Latest Arch Install ISO attached and booting.
GTG

Conclusion:
I hope to have a clean, snappy (pun) Arch desktop that has a 
stable/sane/rolling core, and fun/useful/updated apps above that layer using flatpak.
If you use, test or try these scripts.  Thank You.
Any feedback, fixes,  improvements, whatnot would be nice.
-bt

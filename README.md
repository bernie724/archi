# archi
### Purpose
A personal set of scripts to automate the installation of Arch Linux as a Desktop system. 
I am moving away from distro package manangers and using flatpak more.
Arch seemed to be a good fit for that.
I have nothing to do with Arch Linux of flatpak for that matter, this is for my personal use.

Make sure to read: https://wiki.archlinux.org/title/installation_guide 

These scripts will **blowup** your system or virual machine. 

**Only use these scripts for testing and fun!!!** 
```bash
#Boot the Arch Linux Install iso [on a VM is recommended] 
#partitions sda1 sda2 sda3 as in the doc [there is a script for this, sort of...]
#These scripts should be a tarball somewhere local say /tmp/archi.tgz  
#scp to them to the install iso ~/ 
scp username@10.0.0.1:/tmp/archi.tgz .
tar xzpf archi.tgz 
cd archi
./arch0base.sh
```
The install goes in 3 stages: 
|Stage | Script | Info                                                             |
| ---- | ------ | -----------                                                      |
| 1    | arch0base.sh | this is format/base/sanity                                 |
| 2    | arch1core.sh | this is after arch-chroot, bootloader/pacman core          |
| 3    | arch2main.sh | this is after reboot, user installed main/desktop/flatpak  |

follow the end dialog *of each script* for the next steps... 
#### Goal
My goal is to have a clean, snappy (pun) Arch desktop system that is light on core and uses flatpak when available and sane. I like to look forward and find the nice things that are happening in tech. For my desktop I like futuristic not modern, what ever happened to beryl.. (-: If you use, test or try these scripts.  Thank You. Any feedback, fixes, improvements, whatnot would be nice. 

-BT [3/28/2023] 


ps SuperDeluxDiskMangler.sh is for the brave or crazy that [tries] sets up the /dev/sda 

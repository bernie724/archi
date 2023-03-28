# archi
### Purpose
A personal set of scripts to automate (very little interaction) the installation of Arch Linux as a Desktop System *archi*. 

I am moving systems away from distro package managers (as much as I can) to be more nimble as an operator, in so creating clean modular deployments, and maintaining such systems with an intelligent administrative experience (IAE). I rely heavily on flatpak (seems to be a thing) for this deployment.

I have nothing to do with Arch Linux or flatpak for that matter, this is for my personal use.

Make sure to read: https://wiki.archlinux.org/title/installation_guide 

These scripts will **blowup** your system or virual machine. 
**Only use these scripts for testing and fun!!!**
```bash### Arch Done!
#Boot the Arch Linux Install iso [on a VM is recommended] 
#partitions sda1 sda2 sda3 as in the doc [there is a script for this, sort of...]
#These scripts should be a tarball somewhere local say /tmp/archi.tgz  
#scp to them to the install iso ~/ 
scp username@10.0.0.1:/tmp/archi.tgz .
#tar xzpf archi.tgz # for gzip
tar xpjf archi.bz2  # for bz2 comp
cd archi
./arch0base.sh
```
![archi1](https://user-images.githubusercontent.com/20193396/228312615-645f7cac-6743-4942-aad7-964aef24875e.png)

The install goes in 3 stages: 
|Stage | Script | Info                                                             |
| ---- | ------ | ----                                                             |
| 1    | arch0base.sh | this is format/base/sanity                                 |
| 2    | arch1core.sh | this is after arch-chroot, bootloader/pacman core          |
| 3    | arch2main.sh | this is after reboot, user installed main/desktop/flatpak  |

follow the end dialog *of each script* for the next steps... 
#### Goal
My goal is to have a clean, snappy (pun) Arch desktop system that is light on core and uses flatpak when available and sane. I like to look forward and find the nice things that are happening in tech. For my desktop I like futuristic not modern, what ever happened to beryl.. (-: If you use, test or try these scripts.  Thank You. Any feedback, fixes, improvements, whatnot would be nice. 

-BT [3/28/2023]

### Finished Desktop [xfce4]
![archi4done](https://user-images.githubusercontent.com/20193396/228312917-9b11c109-bc28-46ba-a7ae-df6fad56bbe2.png)
#### Stats
|Resource     | Stat | Desc                |
| ----        | ---- | ----------------    |
| Mem         | 586MB| Idle desktop        |
| /           | 5.9G | After full install  |
| flatpak     | 10G  | 33 apps installed   |
| pacman      | #pkg | 56 (149 with deps)  |


|Script     | Start | Finish | Total  |
| ---       | ----  | ---    | -----  |
| arch0base | 11:42 | 11:44  |  2 min |
| arch1core | 11:45 | 11:54  |  9 min |
| arch2main | 11:56 | 12:08  | 12 min |

|VM Host | Info                                                           | 
| ---    | -----------------------                                        |
|Linux   | (Ubuntu 11.3.0-1ubuntu1~22.04) [kernel:5.19.0-35-generic]      |
|Intel   | CPU [Sky Lake]: Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz*     |

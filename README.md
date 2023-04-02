# archi
### Purpose
A personal set of scripts to fully automate (no interaction) the installation of Arch Linux as a complete Desktop System. 

I am moving systems away from distro package managers (as much as I can) to be more nimble as an operator, in so creating clean modular deployments, and maintaining such systems with an intelligent administrative experience. I rely heavily on flatpak for this deployment.

I have nothing to do with Arch Linux or flatpak for that matter, this is for my personal use.

Make sure to read: https://wiki.archlinux.org/title/installation_guide 

**WARNING:** Do not run these scripts anywhere but on a booted Arch Linux Install ISO [VM is Only Recommended].  **These scripts will Obliterate any system with root access.**  These scripts are for testing and fun only!!!
#### Pre Install
Boot the latest Arch Linux Install ISO on the system that will do a **full and complete** install. [VirutualBox Guest is the only install tested] 

Copy and unpack the archi.tgz file to the booted Arch Install ISO  
```sh
scp username@10.0.0.1:/tmp/archi.tgz .
tar xzpf archi.tgz # for gzip
```
#### Configuring the scripts (optional)
I would review and leave the settings for the first run, these scripts dont have a lot of checks yet, the config file is archi/archi.conf and The install sets are located @ archi/forsys/sets 

e.g. vim/nano archi.conf to suit your install. default: user archi pass archi [the script will tell you]

#### Install Overview
The install is **two commands** with **NO** interaction:

|Step  | Script | Info                                                             |
| ---- | ------ | ----                                                             |
| 1    | arch0base.sh    | this is format/base/sanity and to chroot                |
| 2    | arch0install.sh | this is after arch-chroot, bootloader/desktop/apps      |

#### Start Install
```sh
#To start run from the unpacked archi.tgz archi/ directory
cd archi/; ./arch0base.sh
#The dialog at the end gives instructions to start the second script.
cd /usr/local/archi; ./arch0install.sh 
```
##### When complete, the total system is installed, with all included flatpaks and a Desktop GUI (xfce4)

### Finished Desktop
![archiComplete](https://user-images.githubusercontent.com/20193396/229312252-cf00e46d-e456-4ba9-ada8-c11ac1826290.png)
![archiOpen](https://user-images.githubusercontent.com/20193396/229312258-fdd0f36c-873a-4eca-922b-9f1a25629af1.png)
![archiMinimized](https://user-images.githubusercontent.com/20193396/229314436-9343d304-1261-4e01-8cd6-261193597ff4.png)

#### Stats
|Resource     | Stat | Desc                         |
| ----        | ---- | ----------------             |
| Mem         | 586MB| Idle Desktop [xfce4]         |
| /           | 5.9G | Full install                 |
| flatpak     | 10G  | 33 apps     (47 with deps)   |
| pacman      | -    | 56 installs (149 with deps)  |


|Script        | Start | Finish | Total  |
| ---          | ----  | ---    | -----  |
| arch0base    | 11:42 | 11:44  |  2 min |
| arch0install | 11:44 | 12:05  | 21 min |


|VM Host | Info                                                           | 
| ---    | -----------------------                                        |
|Linux   | (Ubuntu 11.3.0-1ubuntu1~22.04) [kernel:5.19.0-35-generic]      |
|Intel   | CPU [Sky Lake]: Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz*     |
|laptop  | 8 logical CPUs (3.80GHz) and 16GB of RAM                       |

#### Conclusion

With these scripts I can move away from all distro package managers on all Desktop (GUI) systems I create.   
This script creates a clean, snappy (pun) Arch desktop that is manageable, safe and fun. 
My basic desktop requirements are, a granite like stability at the core and futuristic application availability in the operator space.
What ever happened to beryl.. (-:

If you use, test or try these scripts '**Thank You**'. Any feedback, fixes, improvements, whatnot would be nice. 

-BT [3/28/2023]

*archi comes from a.r.c.h.i.(e) from the tabletop rpg game Rifts 'Artificial Robot Cerebellum Housing Intellect (Experiment)'*

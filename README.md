# archi
### Purpose
A personal set of scripts to fully automate the installation of Arch Linux as a complete Desktop System; currently only as a VM. 

**Note:** This design is a format I am interested in setting up and testing. The script's config can be changed to your personal preferences **[change archi.conf file]** see optional.

I have nothing to do with Arch Linux or flatpak for that matter, this is for my personal use.

Make sure to read: https://wiki.archlinux.org/title/installation_guide 

**WARNING:** Do not run these scripts anywhere but on a booted Arch Linux Install ISO [VM is Only Recommended].  **These scripts will Obliterate any system with root access.**  These scripts are for testing and fun only!
#### Install
Boot the latest Arch Linux Install ISO on the system that will do a **full and complete** install. [VirutualBox Guest is the only install tested] 

Arch Download: https://archlinux.org/download/

Global Mirror: http://mirror.rackspace.com/archlinux/iso/latest/

VirutalBox: https://www.virtualbox.org/wiki/Downloads

#### Two ways to get the archi.tgz file to the booted Arch Linux ISO
##### Method #1
From the Arch Linux booted ISO. ISO doesn't have git:
```sh
curl -s -L https://github.com/bernie724/archi/raw/main/archi/archi.tgz > archi.tgz
tar xzpf archi.tgz
cd archi/; ./arch0base.sh 
#This will have a final warning, and then start and complete the install
```
##### Method #2
Copy and unpack the archi.tgz (above) to a booted Arch Install ISO and run arch0base.sh  
```sh
#from a local host
git clone https://github.com/bernie724/archi # @ ~/ on 10.0.0.1
#from the booted iso
scp username@10.0.0.1:~/archi/archi/archi.tgz .
tar xzpf archi.tgz
cd archi/; ./arch0base.sh
#This will have a final warning, and then start and complete the install
```
![simplescp](https://user-images.githubusercontent.com/20193396/230524685-c2e340a2-4596-49de-85f3-539b1a61c481.png)
#### Configuring the scripts (optional)
I would review and leave the settings for the first run, these scripts dont have a lot of conditional checks yet, the config file is archi/archi.conf and the install sets are located @ archi/forsys/sets
```sh
curl -s -L https://github.com/bernie724/archi/raw/main/archi/archi.tgz > archi.tgz
tar xzpf archi.tgz
cd archi/
vim archi.conf # or nano
./arch0base.sh
```
#### Install Overview
After configuring (or not the target is a virtual env) the archi.conf (as already explained) the install is one command with no interaction:

|Step  | Script | Info                                                                |
| ---- | ------ | ----                                                                |
| 1    | arch0base.sh    | this is the install command, format/linux/core/sanity      |
| 2    | arch0install.sh | this is after arch-chroot, boot/arch/daemons/desktop/apps  |
| conf | archi.conf      | use this file to customize an install                      |

##### When complete, the total system is installed, with all included flatpaks and a Desktop GUI (xfce4)
### Finished Desktop
![archiComplete](https://user-images.githubusercontent.com/20193396/229312252-cf00e46d-e456-4ba9-ada8-c11ac1826290.png)
![archiOpen](https://user-images.githubusercontent.com/20193396/229312258-fdd0f36c-873a-4eca-922b-9f1a25629af1.png)
![archiMinimized](https://user-images.githubusercontent.com/20193396/229314436-9343d304-1261-4e01-8cd6-261193597ff4.png)

###### still need aliens (aur), There is a script for that.
![aliens](https://user-images.githubusercontent.com/20193396/230786626-befd98c8-e870-4ea8-9a12-c1b4bf2a28a6.png)


#### Stats
|Resource       | Stat    | Desc                             |
| ----          | ----    | ----------------                 |
| Mem           | 586MB   | Idle Desktop [xfce4]             |
| /             | 5.9G    | Full install                     |
| flatpak       | 10G     | 33 apps     (47 with deps)       |
| pacman        | -       | 56 installs (651 core/deps)      |
| tasks/threads | 75/135  | Idle Desktop [xfce4]             |
| tasks/kthreads| 31/93   | root Console                     |
| boot times    | 26s/48s | console/xfce4 [vm 2x2 cpu/mem]   |


|Script        | Start | Finish | Total  |
| ---          | ----  | ---    | -----  |
| arch0base    | 11:42 | 11:44  |  2 min |
| arch0install | 11:44 | 12:05  | 21 min |


|VM Host | Info                                                           | 
| ---    | -----------------------                                        |
|Linux   | (Ubuntu 11.3.0-1ubuntu1~22.04) [kernel:5.19.0-35-generic]      |
|Intel   | CPU [Sky Lake]: Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz*     |
|laptop  | 8 logical CPUs (3.80GHz) and 16GB of RAM                       |

#### archi running

![archithreerun](https://user-images.githubusercontent.com/20193396/230749166-5b3c624a-299d-45e7-8664-ab01cc5bf844.png)

If you use, test or try these scripts, thanks. Feedback, fixes, improvements, screenshots, whatnot would be nice, the discussion board should work. 

*archi is inspired from a.r.c.h.i.(e) from the tabletop rpg game Rifts 'Artificial Robot Cerebellum Housing Intellect (Experiment)'*

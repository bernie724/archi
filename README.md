# archi
### Purpose
A personal set of scripts to automate (no interaction) the installation of Arch Linux as a Desktop System *archi*. 

I am moving systems away from distro package managers (as much as I can) to be more nimble as an operator, in so creating clean modular deployments, and maintaining such systems with an intelligent administrative experience. I rely heavily on flatpak for this deployment.

I have nothing to do with Arch Linux or flatpak for that matter, this is for my personal use.

Make sure to read: https://wiki.archlinux.org/title/installation_guide 

**WARNING:** Do not run these scripts anywhere but on a booted Arch Linux Install ISO.  These scripts can *oblitorate* any system with root access.

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

The install goes in 2 Step with no interaction: 
|Stage | Script | Info                                                             |
| ---- | ------ | ----                                                             |
| 1    | arch0base.sh    | this is format/base/sanity and to chroot                |
| 2    | arch0install.sh | this is after arch-chroot, bootloader/desktop/apps      |

#### Goal
Move away from all distro package managers on all Desktop (GUI) systems.   The final system will be a clean, snappy (pun) Arch desktop that is managable, safe and fun. For my desktop I like futuristic not modern, what ever happened to beryl.. (-: If you use, test or try these scripts.  Thank You. Any feedback, fixes, improvements, whatnot would be nice. 

-BT [3/28/2023]

### Finished Desktop
![archiComplete](https://user-images.githubusercontent.com/20193396/229312252-cf00e46d-e456-4ba9-ada8-c11ac1826290.png)
![archiOpen](https://user-images.githubusercontent.com/20193396/229312258-fdd0f36c-873a-4eca-922b-9f1a25629af1.png)
![archiComplete](https://user-images.githubusercontent.com/20193396/229312261-09e96a70-8077-47c6-8d31-bddf06c284eb.png)

#### Stats
|Resource     | Stat | Desc                         |
| ----        | ---- | ----------------             |
| Mem         | 586MB| Idle Desktop [xfce4]         |
| /           | 5.9G | Full install                 |
| flatpak     | 10G  | 33 apps     (47 with deps)   |
| pacman      | -    | 56 installs (149 with deps)  |


|Script     | Start | Finish | Total  |
| ---       | ----  | ---    | -----  |
| arch0base | 11:42 | 11:44  |  2 min |
| arch1core | 11:45 | 11:54  |  9 min |
| arch2main | 11:56 | 12:08  | 12 min |

|VM Host | Info                                                           | 
| ---    | -----------------------                                        |
|Linux   | (Ubuntu 11.3.0-1ubuntu1~22.04) [kernel:5.19.0-35-generic]      |
|Intel   | CPU [Sky Lake]: Intel(R) Core(TM) i7-7700HQ CPU @ 2.80GHz*     |
|laptop  | 8 logical CPUs (3.80GHz) and 16GB of RAM                       |

*archi comes from a.r.c.h.i.(e) from the tabletop rpg game Rifts 'Artificial Robot Cerebellum Housing Intellect (Experiment)'*


## PlopKexec-64bit
A fork of [Elmar Hanlhofer's PlopKexec](https://www.plop.at/en/plopkexec/download.html) linux & kexec-based Linux bootloader with an updated LTS kernel & tools without 32-bit support

![screenshot](https://github.com/stelios333/PlopKexec/blob/master/screenshots/plopkexec1.jpg?raw=true)

## Directories
busybox - BusyBox source code
iso - Iso build directory
kernel	- Linux kernel
kexec	- Kexec source code
src	- PlopKexec program source code

## Compiling
First you will need to install the required build tools for the Linux kernel, kexec and busybox.
````
sudo apt install bc binutils bison dwarves flex gcc git gnupg2 gzip libelf-dev libncurses5-dev libssl-dev make openssl pahole perl-base rsync tar xz-utils glibc-static
```` 

If you intend to create a bootable iso you will also need to install `syslinux-utils`
If you are not using a debian-based distro ask an LLM what the equivalent packages are for your distro.

To build just the kernel run: `sh build.sh`

To build the kernel and create a bootable iso run `sh build.sh iso`

The kernel and the iso image can be found in the build directory. The kernel is compiled with EFI stub activated so it is directly bootable on UEFI systems. The iso image will work on both uefi and legacy BIOS systems and can be burned to a USB flash drive using tools like `dd` or BalenaEtcher 

## Supported filesystems:
- ext2
- ext3
- ext4
- vfat
- iso9660
- f2fs
- nilfs2
- ntfs
- btrfs (no subvolume support)
- reiserfs
- xfs
- hfsplus

## Config files
At the moment parsing config files from other bootloaders, particularly grub, is not well-supported and will likely not work. Therefore it is recommended to create a syslinux-style config file named `plopkexec.cfg` in the partition of the Linux kernel you are trying to load at either one of these directories:
- /  
- /boot/  
- /syslinux/  
- /isolinux/  
- /extlinux/  
- /efi/boot/

List of supported syslinux commands:
-   APPEND
-   DEFAULT
-   INCLUDE
-   INITRD
-   KERNEL
-   LABEL
-   MENU LABEL
-   TIMEOUT
 
Example:
```
DEFAULT debian
TIMEOUT 80
MENU TITLE Debian GNU/Linux

LABEL debian
    MENU LABEL Debian GNU/Linux
    LINUX /vmlinuz
    APPEND root=UUID=5f931572-cec7-430d-bd06-14320e90c79b ro quiet splash
    INITRD /initrd.img

LABEL debiannosplash
    MENU LABEL Debian GNU/Linux (No splash screen)
    LINUX /vmlinuz
    APPEND root=UUID=5f931572-cec7-430d-bd06-14320e90c79b ro quiet
    INITRD /initrd.img
```

## Hotkeys
- E ... Edit entry before booting.
- L ... Log view.
- Q ... Back to the menu from log view.
- P ... Power off.
- R ... Restart.
- S ... Shell (Busybox).
- Left/Right keys ... Change view Menu/Log/Dmesg.



[Link to original documentation](https://www.plop.at/en/plopkexec/full.html)
# Arch Linux

Simple steps to install [Arch Linux](https://www.archlinux.org/) quick and easily.
For a more detailed installation guide refer to the [Arch Linux Beginners' Guide](https://wiki.archlinux.org/index.php/Installation_guide).

You can download the last Arch release [here](https://www.archlinux.org/download/).
The image can be burned into a CD or written to a USB stick using `dd` ([Rufus](https://rufus.akeo.ie/) or [Wind32DiskImage](https://sourceforge.net/projects/win32diskimager/) on _Windows_).

## Preparation

Steps required before the installation.

### Keyboard Layout

Find your keyboard layout:

    # ls /usr/share/kbd/keymaps/**/*.map.gz

Then set your keyboard layout with `loadkeys`.

    # loadkeys /usr/share/kbd/keymaps/i386/qwerty/pt-latin9.map.gz

### Internet Connection

Check if you have an active internet connection, you should get a response from a ping.

    # ping -c 3 google.com

If no connection is available, see [Network configuration](https://wiki.archlinux.org/index.php/Network_configuration).
You can also use the `wifi-menu` command to connect to WiFi.

### System Clock

Make sure your system clock is accurate:

    # timedatectl set-ntp true
    # timedatectl status

If the clock doesn't match your timezone, you can list the timezones with:

    # timedatectl list-timezones

Set the new timezone with:

    # timedatectl set-timezone Europe/Lisbon

### Boot Mode

Verify your boot mode to check if your system supports **UEFI** or **BIOS**.
If you type the following command and and directory exists and is populated, then you are booted in UEFI mode.

    # ls /sys/firmware/efi/efivars

**Note**: If you are installing Arch in a VM remember to change the motherboard settings to support UEFI.

# UEFI / GPT Partition

If your motherboard doesn't support UEFI or you want to dual boot with Windows, you need a MBR
partition table, otherwise you should use GPT. This guide assumes we are using GPT.

Find the block device name with `lsblk`. In my case, the block device or SSD on which I will be installing Arch Linux is `/dev/sda`.

### Partitioning

There are many tools that can be used to create the partition table (like cgdisk, parted), I will be using `parted`.

    # parted /dev/sda

We have to first create a **partition table** with gpt.

    (parted) mklabel gpt

It will warn you about destroying all data, type **yes**.

In this case we will be creating 4 partitions: UEFI boot partition, root partition, swap (optional) and home partition (optional) using the following
pattern:

    (parted) mkpart part-type fs-type start end

In case of UEFI `boot` partition, the part-type is `ESP` (EFI System Partition); the file system will be FAT 32 and we will allocate at least 512MB for this partition.

    (parted) mkpart ESP fat32 1MiB 513MiB

Set boot flag on it:

    (parted) set 1 boot on

For the `root` partition:

    (parted) mkpart primary ext4 513MiB 20GiB

For swap the file system will be `linux-swap`. If you have a good amount of RAM, you don’t really need swap.

    (parted) mkpart primary linux-swap 20GiB 22GiB

For additional partitions like home, just use the same pattern. If you want to use the remaining space of the device, use the 100% as the end point:

    (parted) mkpart primary ext4 22GiB 100%

Check if the partitions are created correctly by running the `print` command.

    (parted) print

If everything looks good, exit `parted`:

    (parted) quit

### Formatting

You need to format each of your partitions, except for swap. All available partitions on a device (sda, sdb, etc.) can be listed with the following command:

    # lsblk /dev/sda

Format the boot partition as FAT32 (replace sdxY with the relevant partition):

    # mkfs.fat -F32 /dev/sdxY

Activate swap:

    # mkswap /dev/sdxY
    # swapon /dev/sdxY

Format your `root`, `home` or any additional `data` partition with the same pattern:

    # mkfs.ext4 /dev/sdxY

### Mount the partitions

Mount the root partition to the /mnt directory of the live system:

    # mount /dev/sdxY /mnt

In my case it was sda2:

    # mount /dev/sda2 /mnt

Create `boot` directory to mount the UEFI partition:

    # mkdir -p /mnt/boot

Mount the ESP to boot:

    # mount /dev/sdxY /mnt/boot

In my case it will be:

    # mount /dev/sda1 /mnt/boot

Mount any additional partitions like home following the same pattern as boot.

## Installation

Install the base packages:

    # pacstrap -i /mnt base base-devel

Generate an [fstab](https://wiki.archlinux.org/index.php/Fstab) file, to define how disk partitions should be mounted into the filesystem:

    # genfstab -U /mnt >> /mnt/etc/fstab

Optionally, check the newly generated fstab file:

    # cat /mnt/etc/fstab

Change root to the new system:

    # arch-chroot /mnt /bin/bash

### Locale

Configure language for the system by editing the ‘locale.gen’ file:

    # nano /etc/locale.gen

Find the entry for your language, uncomment it and save the file.

    LANG=en_GB.UTF-8

Then run the following commands, one by one:

    # locale-gen
    # echo LANG=en_GB.UTF-8 > /etc/locale.conf
    # export LANG=en_GB.UTF-8

### Timezone

Configure the time zone.

    # tzselect

Once all steps are completed, it will show you the selected time zone. Now create a symlink to it:

    # ln -s /usr/share/zoneinfo/Zone/SubZone > /etc/localtime

In my case it was:

    # ln -s /usr/share/zoneinfo/Europe/Lisbon > /etc/localtime

Set hardware clock to UTC:

    # hwclock --systohc --utc

## Boot loader

Install the packages grub and efibootmgr:

    # pacman -S grub efibootmgr

Install the **GRUB UEFI** application

    # grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=grub

**UEFI firmware workaround**: Some UEFI firmware requires that the bootable .efi stub have a specific name and be placed in a specific location: /boot/EFI/boot/bootx64.efi:

    # mkdir /boot/EFI/boot
    # cp /boot/EFI/grub/grubx64.efi /boot/EFI/boot/bootx64.efi

If you have an **Intel CPU**, in addition to installing a boot loader, install the intel-ucode package:

    # pacman -S intel-ucode

After installing the intel-ucode package, regenerate the GRUB config to activate loading the microcode update:

    # grub-mkconfig -o /boot/grub/grub.cfg

## Network configuration

### Hostname

Give our system a decent host name:

    # echo mainframe > /etc/hostname

Install **necessary** packages for _wired_ and _wireless_ connections:

    # pacman -S networkmanager
    # systemctl enable NetworkManager.service
    # nmtui-connect

**Alternative** way:

Run `ip link` to find your ethernet interface name (it should starts with en, eg. enp0s25).

    # ip link

When only requiring a single wired connection, enable the dhcpcd service, where MY_EN is your ethernet interface:

    # systemctl enable dhcpcd@MY_EN.service

For wireless, install the iw, wpa_supplicant and dialog packages:

    # pacman -S iw wpa_supplicant dialog

## Root user and Reboot

Create the password for the root. Run the following command:

    # passwd

Leave the chroot environment:

    # exit

And unmount the partition:

    # umount -R /mnt

Then **shutdown** the system:

    # shutdown

Remove the USB drive that you used to install Arch and reboot the system.

We now have a completely working Arch Linux system, however, there is still a lot of things to configure.

## Keyboard Configuration

List all available keymaps using:

    $ localectl list-keymaps

To search for a keymap, use the following command, replacing `search_term` with the `code` for your language, country, or layout:

    $ localectl list-keymaps | grep -i search_term

A persistent keymap can be set in `/etc/vconsole.conf`.

For convenience, `localectl` may be used to set console keymap.

    $ localectl set-keymap --no-convert keymap

## Add users

Create a new system user so we can stop using the root one. Pattern:

    # useradd -m -G additional_groups -s login_shell username

Example:

    # useradd -m -G wheel,users greven

Create a password for this user:

    # passwd greven

Install `sudo`.

    # pacman -S sudo

Give the new user `sudo` powers.

    # EDITOR=nano visudo

Un-comment this line in this file:

    %wheel ALL=(ALL) ALL

Save and close the file with ‘Ctrl+x’ and then type ‘y’ to confirm.

## X-server

Update the pacman repositories:

    $ sudo pacman -Sy

Let's install the display server, graphics drivers and additional components.

    $ sudo pacman -S xorg-server xorg-server-utils

It will ask you to install libgl package, choose the one for your GPU.

Intel GPU:

    $ sudo pacman -S xf86-video-intel

Nvidia (latest cards only, for older cards check the [Arch wiki](https://wiki.archlinux.org/index.php/NVIDIA):

    $ sudo pacman -S nvidia nvidia-libgl

ATI/AMD:

    $ sudo pacman -S xf86-video-ati lib32-mesa-libgl

If you have input devices like a touch-pad install the following:

    $ sudo pacman -S xf86-input-synaptics

## Pacman

Arch Linux is now properly installed.
Here are some pacman commands to install packages on Arch.

Update repositories:

    $ sudo pacman –Sy

Updates the repositories and runs system updates:

    $ sudo pacman –Syu

To install a package:

    $ sudo pacman –S package_name

For multiple packages:

    $ sudo pacman -S virtualbox-guest-dkms virtualbox-guest-dkms virtualbox-guest-modules-lts

Alternative syntax:

    $ sudo pacman -S virtualbox-guest-{dkms,iso,modules,dkms,utils}

Optimize Pacman:

    $ sudo pacman-optimize

Removing packages:

    $ sudo pacman –R package_name

To remove a package and its dependencies:

    $ sudo pacman –Rns

Clean pacman cached packages:

pacman -Sc

## Arch User Repository

If a package is not in the official repository there is always the Arch User Repository (AUR).
Manually compiling a package from AUR is easy.

Find the package in [AUR](https://aur.archlinux.org/).

Clone the package using Git:

    $ git clone <package-query>.git

Change directory into the downloaded package:

    $ cd package-query

Run the makepkg command:

    $ makepkg –sri

### Yaourt

Alternatively to manual compiling packages from AUR we can use Yaourt.

Install Yaourt from AUR first.

Refresh repository info:

    $ yaourt -Syu --aur

This command sync database, upgrades installed packages and AUR packages.

Yaourt can also install packages that are already available in the official repos.

    $ yaourt -S <package-query>

If you want to search only AUR skipping packages from official repo then use without –S or use –aur flag:

    $ yaourt --aur <package-query>

## After Install

We already have a working Arch Linux system, there are several steps we can take to improve our system, like installing
a graphical client like Gnome:

    $ sudo pacman -S gnome gnome-extra

If you are going to use only Gnome on this system then you need to enable Gnome Display Manager aka gdm and set it to start at system reboot:

    $ sudo systemctl start gdm.service
    $ sudo systemctl enable gdm.service

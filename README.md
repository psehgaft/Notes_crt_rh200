# Notes_crt_rh200

## SSH

```sh
ssh-keygen [name or default empty]
ssh-copy-id [user@server]
ssh -i .ssh/[key]
eval $(ssh-agent)
ssh-add .ssh/[key]
```

## Hard and Soft links

```sh
ln -s /[path]/[folder or file] /[path]/[folder or file]

ls -l /[path]/[folder or file]
```

## Users

```sh
id
id [user]

ps -au
```

Login as root
```sh
su -
```

Login as another user

```sh
su - [users]
```

Add to sudoers file `/etc/sudoers.d/[user]`

```/etc/sudoers.d/[user]
[user]  ALL=(ALL)  ALL

[goup]  ALL=(ALL)  ALL

[command]  ALL=(ALL)  NOPASSWD:ALL
```

Add users and passwords

```sh
useradd [user]
passwd [user]
```

# Practice 200

## Root

Enter grupo pres [e]
Remplace

```grub
rhgb quiet

to

rd.break enforcing=0
```

On prompt

```sh
mount -o remount,rw /sysroot
chroot /sysroot
whoami
passwd
...
exit
```

## Repos

Validatin repos

```sh
dnf repolist all
cd /etc/yum.repos.d/
ls
```

Configuring repos

```sh
dnf config-manager --add-repo [URL]
dnf repolist all
cd /etc/yum.repos.d/
ls
```

## Timezone

Validate

```sh
timedatectl
timedatectl set-timezone "america/new_york"
timedatectl set-ntp yes
```

Install Chrony

```sh
rpm -qa | grep chrony

dnf install -y chrony
systemctl status chronyd
```

Edit chrony conf

```sh
vi /etc/chrony.conf
```


## DNS / gateway


```sh
cd /sysconfig/network-scripts/
vi [adapter-name-config-file]
```

## Add network

Validate

```sh
nmcli connection show
```
Edit config

```sh
nmcli connection modify System\ eth1 +ipv4.addresses [ip/mask]
nmcli connection reload

nmcli connection modify System\ eth1 ipv6.method manual ipv6.addresses [ip::###/mask]
nmcli connection reload
```

Validate

```sh
nmcli connection show System\ [adapter-name]
ip a
```

## IP forwarding

Edit file `/etc/sysctl.conf`

```/etc/sysctl.conf
...
net.ipv4.ip_forward=1 
```
Validate

```sh
cat /proc/sys/net/ipv4/ip_forward
```

## Multiuser config

```sh
systemctl set-default multi-user.target
systemctl get-default 
```

Edit GRUB `/etc/default/grub`

```/etc/default/grub
GRUB_CMDLINE_LINUX="....... rhgb quiet"

to

GRUB_CMDLINE_LINUX="....... "
```

Charge config

```sh
grub2-mkconfig -o /boot/grub2/grub.cfg
```

## Volumes

Validation

```sh
lsblk

fdisk -l
```

Create partition

```sh
fdisk -l /dev/sdb
fdisk /dev/sdb
```

on fdisk

```fdisk
n
+[cuantity on mb]M
t
8e
w
```

Create phisical volume

```sh
pvcreate /dev/sdb1

vgcreate [name] /dev/sdb1
```

Validation

```sh
partprobe /dev/sdb
fdisk -l /dev/sdb
lsblk
pvs
vgs
```

Create a logical volume

```sh
lvcreate -L [cuantity on Gb]G -n [name] [volumegroup-name]

vgcreate [name] /dev/sdb1
```

Validation

```sh
partprobe /dev/sdb
fdisk -l /dev/sdb
lsblk
pvs
vgs
lvs
```

Format logical volume

```sh
mkfs.xfs /dev/[volumegroup-name]/[lovical-volume-name]
lsblk -f

mkdir -p [mount-point-path] 
```

Mount

```sh
mkdir -p /[mount-point-path] 
```

Edith `/etc/fstab`

```/etc/fstab
UUID=[filesistem] /[mount-point-path] xfs defaults 0 0

```


```sh

```



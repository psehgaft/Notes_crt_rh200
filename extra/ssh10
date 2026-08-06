#! /bin/bash

######## Root passwd

# on GRUB menu press "e"
# add rw init=/bin/bash

mount -o remount,rw /
passwd
touch /.autorelabel
exec /sbin/init
/sbin/reboot -f

######## Manage basic Networking

vi /sysconfig/network-scripts/[adapter-name]
hostnamectl set-hostname [hostname]

######## SSH
sudo vi /etc/ssh/sshd_config
...
PermitRootLogin yes
...

######## Config Repos

dnf config-manager --add-repo [url]
yum config-manager --add-repo [url]
yum repolist all
yum config-manager --disable rht-updates

vi  /etc/yum.repos.d/server01_[repo-name]
---
gpgcheck=0
---

######## HTTP Selinux

semanage port -a -t http_port_t -p tcp 82

firewall-cmd --permanent --add-service={http,https}
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload

######## Users / UUid

groupadd [name-group]
useradd -G [name-group] [username]
# Follow user has not access to an interactive shell 
useradd -s /sbin/nologin [username]
passwd [username]

######## CRON Job

[user]
crontab -u [user] -e
* * * * * logger echo "hello" 

######## Colab users / files

mkdir /[dir-path]
chown :[name-group] [dir-path]
chmod 770 [dir-path]
# files creaed on [dir-path] automatically hace goup ownership set to the [name-group] group
chmod g+s [dir-path] 

######## NTP

timedatectl set-timezone "americas/new_york"
timedatectl set-ntp true
hwclock --systohc

vi /etc/chroney.conf
---
pool [servername] iburst
---

systemctl start chronyd
systemctl enable chronyd

######## AutoFS

dnf install autofs nfs-utils

mkdir -p /[mnt-point-folder]
chmod 755 /[mnt-point-folder]

vi /etc/auto.master.d/[mnt-point-folder].autofs
---
/[mnt-point-folder]	/etc/auto.[mnt-point-folder]
---

vim /etc/auto.[mnt-point-folder]
---
*           -rw,sync,fstype=nfs4 [server]:[nfs-path]/&
username	-rw,sync,fstype=nfs4 [server]:[nfs-path]/username
---

systemctl enable autofs
systemctl start autofs

######## Share folders

cp [ori-path] [dir-path]
chmod ugo-x [dir-path]
setfacl -m u:[user]:rwx [dir-path]
chmod o-r [dir-path]

######## User ID

useradd -u [id-number] [username]

######## Find files and tar

find [dir-path] -user [username] -exec cp "{}" [destination-path]

grep [word] [file] > [file]

tar -vcjf [folder-name].tar.bz2 [folder-name]

######## Resize Fs

lvextend -L +[cuantity]M -r /dev/[vg]/[lv]
xfs_growfs [mountpoint]

######## SWAP / Volumes

parted /dev/vdb mklabel gpt

parted /dev/vdb print
parted /dev/vdb mkpart myswap linux-swap [start]MB [end]MB
    
mkswap /dev/vdb1
swapon /dev/vdb1
lsblk --fs /dev/vdb1
# ... UUID
vi /etc/fstab
---
UUID=[UUID]  swap  swap  defaults  0 0
---
systemctl daemon-reload
swapon -a
 
###  lvm

parted /dev/vdb mkpart backup xfs 2048s 2GB
pvcreate /dev/vdb2 
vgcreate [volumegroup] /dev/vdb2
lvcreate -n [volumename] -L [PE-Cuantity] [volumegroup]
mkfs.ext3 /dev/[volumename]/[volumegroup]
vi /etc/fstab
---
/dev/[volumegroup]/[volumename]  [mountpoint] xfs  defaults 0 0
---
systemctl daemon-reload

######## Tuning

dnf install tuned
systemctl is-enabled tuned
systemctl is-active tuned
sudo tuned-adm active
tuned-adm profile [profile]
tuned-adm recommend

######## Container

useradd [user]
passwd [user]
loginctl enable-linger [user]
ssh [user]@[server]

## [user]
podman image build -t [imageName]:[tag] [context directory]
mkdir [local-path]
chown -R [user]:[user] [local-path]
chmod 0644 [local-path]

podman login [registry]
podman build -t [container-name]:[tag] [context directory]

podman run -d --name [container-name] -p [server-pod]:[container-port] -v [local-path]:[continer-path]:Z [container-path]/[container-name]:[tag]

mkdir -p ~/config/systemd/user
cd ~/.config/systemd/user
podman generate systemd --name [container-name] --files --new
systemctl --user daemon-reload

systemctl --user enable --now container-[container-name].service

######## Extra
sudo vim /etc/login.defs     # So that all new users inherit [days] days by default
PASS_MAX_DAYS   [days]
PASS_MIN_DAYS   [days]
PASS_WARN_AGE   [days]

#! /bin/bash

######## Manage basic Networking

vi /sysconfig/network-scripts/[adapter-name]
hostnamectl set-hostname [hostname]

######## Config Repos

dnf config-manager --add-repo [url]
yum config-manager --add-repo [url]
yum repolist all
yum config-manager --disable rht-updates

vi  /etc/yum.repos.d/server01_[repo-name]
---
gpgcheck=1
---

######## HTTP Selinux

dnf install -y httpd
systemctl start httpd
systemctl enable httpd

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
crontab -e
* * * * * [user] "echo 'hello' >> log"

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

dnf install -y chrony
vi /etc/chroney.conf
---
server [servername] iburst
---

systemctl start chronyd
systemctl enable chronyd

######## AutoFS

yum install autofs nfs-utils
sudo systemctl enable --now autofs

vim /etc/auto.master
/shared	/etc/auto.shared

vim /etc/auto.shared
*	-rw,sync,fstype=nfs4 [server]:[nfs-path]/&

sudo systemctl restart autofs

######## ACL

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

######## Root

## in grub press [e]
rd.break enforcing=0

mount -o remount,rw /sysroot
chroot /sysroot
passwd
touch /.autorelabel

######## Resize Fs

lvextend -L +[cuantity]M -r /dev/[vg]/[lv]
xfs_growfs [mountpoint]

######## SWAP / Volumes

fdisk /dev/sdb
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

fdisk /dev/sdb
pvcreate /dev/vdb2
vgcreate -s 16 [volumegroup] /dev/vdb2
lvcreate -l [PE-Cuantity] -n [volumename] [volumegroup]
mkfs.ext3 /dev/[volumename]/[volumegroup]
vi /etc/fstab
---
/dev/[volumegroup]/[volumename]  [mountpoint] xfs  defaults 0 0
---
systemctl daemon-reload

######## VDO

yum list installed vdo kmod-kvdo
vdo create --name=vdo1 --device=/dev/vdc --vdoLogicalSize=50G
mkfs.xfs -K /dev/mapper/vdo1
cp /usr/share/doc/vdo/examples/systemd /etc/systemd/system/[mountpoint].mount
---
edit [what,where]
---
systemctl enable --now vdo.mount
vdostats --human-readable
cp [filename] [mountpoint]/[filename]

######## Tuning

yum install tuned
systemctl enable --now tuned
sudo tuned-adm active
tuned-adm recommend
tuned-adm profile [profile]

######## Container


vim /etc/systemd/journald/journal.conf
---
[journal]
Storage=persistent
---

mkdir [local-path]
cp -r /var/log/journal/ [local-path]
chown -R [user]:[user] [local-path]
systemctl restart systemd-journald
reboot

[user]
podman login [registry]
podman search [container-name]
podman pull [image]
podman run -d --name [container-name] -p [server-pod]:[container-port] -v [local-path]:[continer-path]:Z [image]:[tag]
mkdir -p ~/config/systemd/user
loginctl enable-linger
podman generate systemd --name [container-name] --files --new
systemctl --user daemon-reload
systemctl --user enable --now container-[container-name].service








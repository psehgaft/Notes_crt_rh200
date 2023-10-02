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

vi /etc/dnf/plugins/subscription-manager.conf
---
enabled=0
---

######## Users / UUid

groupadd [name-group]
useradd -G [name-group] [username]
passwd [username]

# usermod -aG [name-group] [username]
useradd -s /sbin/nologin [username]

useradd -u [id-number] [username]

######## HTTP Selinux

dnf install -y httpd
systemctl start httpd
systemctl enable httpd

chcon -t httpd_sys_content_t [dir-path]

semanage fcontext -a -t httpd_sys_content_t '[dir-path](/.*)?'
# chcon -Rvt httpd_sys_content_t /var/www/html
semanage port -a -t http_port_t -p tcp 82

firewall-cmd --permanent --add-service={http,https}
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --reload

######## CRON Job

crontab -e
* * * * * [user] "echo 'hello' >> log"

######## Colab users / files

mkdir /[dir-path]
chown :[name-group] [dir-path]
chmod ug+w [dir-path]
# files creaed on [dir-path] automatically hace goup ownership set to the [name-group] group
chmod g+s [dir-path] 

######## NTP

timedatectl set-timezone "americas/new_york"
timedatectl set-ntp true

dnf install -y chrony
vi /etc/chroney.conf
systemctl start chronyd
systemctl enable chronyd

######## AutoFS

yum install autofs
sudo systemctl enable --now autofs

vim /etc/auto.master.d/guests.autofs
/remote	/etc/auto.direct

vim /etc/auto.guests
*	-rw,sync,fstype=nfs4	[server]:[nfs-path]/&

systemctl enable --now autofs

######## ACL

chmod 027 [dir-path]
chown [username]: [dir-path]
chmod o-wr [dir-path]
chmod ugo-x [dir-path]
setfacl -m u:toby:rwx [dir-path]


######## Find files and tar

find [dir-path] -user [username] 

grep [word] [file] >> [file]

tar -vcjf [folder-name].tar.bz2 [folder-name]

######## Root

## in grub press [e]
rd.break enforcing=0

mount -o remount,rw /sysroot
chroot /sysroot
passwd
touch /.autorelabel

######## Resize Fs

lvextend -L +[cuantity]M /dev/[vg]/[lv]
xfs_growfs [mountpoint]

######## SWAP / Volumes

parted /dev/vdb mkpart myswap linux-swap 0MB 512MB
udevadm settle
mkswap /dev/vdb1
swapon /dev/vdb1
lsblk --fs /dev/vdb1
# ... UUID
vi /etc/fstab
UUID=[UUID]  swap  swap  defaults  0 0
systemctl daemon-reload
swapon -a

parted /dev/vdb mkpart [partitionname] xfs 512M 400GB
udevadm settle
vgcreate [volumegroup] /dev/vdb2
lvcreate -n [volumename] -L 400M [volumegroup]
mkfs.ext3 /dev/[volumename]/[volumegroup]
vi /etc/fstab
/dev/[volumename]/[volumegroup]  [mountpoint] xfs  defaults 1 2
systemctl daemon-reload

######## VDO

yum list installed vdo
vdo create --name=vdo1 --device=/dev/vdc --vdoLogicalSize=50G
udevadm settle
mkfs.xfs -K /dev/mapper/vdo1
vi /etc/fstab
/dev/mapper/vdo1  [mountpoint] xfs  defaults 1 2
vdostats --human-readable
cp [filename] [mountpoint]/[filename]

######## Tuning

yum install tuned
systemctl enable --now tuned
tuned-adm recommend
tuned-adm profile [profile]

######## Container

useradd [user]
passwd [user]
dnf modile install container* -y
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






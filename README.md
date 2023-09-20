# Notes_crt_rh200

## SSH

```sh
ssh-keygen [name or default empty]
ssh-copy-id [user@server]
ssh -i .ssh/[key]
eval $(ssh-agent)
ssh-add .ssh/[key]
```

# Hard and Soft links

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

```sh

```





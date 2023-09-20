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



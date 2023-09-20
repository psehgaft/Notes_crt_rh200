# Notes_crt_rh200

## SSH
ssh-keygen [name or default empty]
ssh-copy-id [user@server]
ssh -i .ssh/[key]
eval $(ssh-agent)
ssh-add .ssh/[key]

# Hard and Soft links

ln -s /[path]/[folder or file] /[path]/[folder or file]

## Root

Enter grupo pres [e]
Remplace

```grub
rhgb quiet

to

rd.break enforcing=0
```

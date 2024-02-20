On the local system, it is common to find a source of documentation known as the system man pages. These pages are provided by software packages and can be accessed from the command line using the "man" command. Typically, man pages are stored in subdirectories of the /usr/share/man directory.

```sh
man man

man man | col -bx | sed -n "/^  *-k/,/^$/p"

man man | col -bx | sed -n "/^  *-K/,/^$/p"
```

```sh
ls /usr/share/man
```

- The man1 directory contains Executable programs or shell commands.

```sh
ls -al /usr/share/man | grep man

OUTPUT
...
man1
man2
man3
man4
man5
man6
man7
man8
man9
mann
...

```

---
| Section | Content type |
|---------|--------------|
| 1	| User commands	Both executable and shell programs |
| 2	| System calls	Kernel routines that are invoked from user space |
| 3	| Library functions	Provided by program libraries |
| 4	| Special files	Such as device files |
| 5	| File formats	For many configuration files and structures |
| 6	| Games and screensavers	Historical section for amusing programs |
| 7	| Conventions, standards, and miscellaneous	Protocols and file systems |
| 8	| System administration and privileged commands	Maintenance tasks |
| 9	| Linux kernel API	Internal kernel calls |

Search for man Pages by Keyword

```sh
whatis unlink

whatis cowsay

whatis passwd

whatis gedit

whatis tar
```

man command -k option

```sh
man -k unlink

man -k cowsay

man -k passwd

man -k tar
```

To distinguish identical topic names in different sections, man page references include the section number in parentheses after the topic. 

```sh
man 1 unlink

man 1 cowsay

man 1 passwd

man 1 tar

man 5 tar
```

man command -K (uppercase) option searches for the keyword in the full-text page

```sh
man -K unlink

man -K cowsay

man -K passwd
```

Review man structure

```sh
man -K cowsay

mar tar
```


# Exercise

Create a tar file bzip2 format

```sh
man tar | col -bx | sed -n "/^  *-c/,/^$/p"

man tar | col -bx | sed -n "/^  *-j/,/^$/p"

man tar | col -bx | sed -n "/^  *-v/,/^$/p"

man tar | col -bx | sed -n "/^  *-f/,/^$/p"

sudo tar -cjvf ./html.tar.bz2 ./htlm
```

Untar file

```sh
man tar | col -bx | sed -n "/^  *-x/,/^$/p"

man tar | col -bx | sed -n "/^  *-j/,/^$/p"

man tar | col -bx | sed -n "/^  *-v/,/^$/p"

man tar | col -bx | sed -n "/^  *-f/,/^$/p"

sudo tar -xjvf ./html.tar.bz2 ./htlm
```

List of useful man pages

```sh

man 1 vim 
man useradd 
man -k semanage 
man ps
man -k cron 
man 5 crontab 
man fstab
man -k temp
man 5 tmpfiles.d
man -k rsyslog
man 5 rsyslog.conf
man -k nmcli
man -k firewalld
```
man semanage-port

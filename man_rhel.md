On the local system, it is common to find a source of documentation known as the system man pages. These pages are provided by software packages and can be accessed from the command line using the "man" command. Typically, man pages are stored in subdirectories of the /usr/share/man directory.

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

whatis gzip
```

man command -k option

```sh
man -k unlink

man -k cowsay

man -k passwd
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
```
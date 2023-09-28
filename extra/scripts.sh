#! /bin/bash

######## Manage basic Networking

vi /sysconfig/network-scripts/[adapter-name]
hostnamectl set-hostname [hostname]

######## Config Repos

dnf config-manager --add-repo [url]
yum-config-manager --add-repo [url]

######## Users

groupadd [name-group]
useradd [username]
passwd [username]

usermod -aG [name-group] [username]
usermod -s /sbin/nologin [username]

######## HTTP Selinux

dnf install -y httpd
systemctl start httpd
systemctl enable httpd

chcon -t httpd_sys_content_t [dir-path]

semanage fcontext -a -t httpd_sys_content_t '[dir-path](/.*)?'
semanage port -a -t http_port_t -p tcp 82

firewall-cmd --permanent --add-service={http,https}
firewall-cmd --reload

######## CRON Job

* * * * * "su -u user echo 'hello' >> log"

######## Colab users / files

mkdir /[dir-path]
chown :[name-group] [dir-path]
chmod ug+w [dir-path]
chmod 2770 [dir-path]



#! /bin/bash

######## Manage basic Networking

vi /sysconfig/network-scripts/[adapter-name]
hostnamectl set-hostname [hostname]

######## Config Repos

dnf config-manager --add-repo [url]
yum-config-manager --add-repo [url]

######## Users

groupadd [name-group]
useradd -G [name-group] [username]
passwd [username]

# usermod -aG [name-group] [username]
usermod -s /sbin/nologin [username]

useradd -g [id-number] [username]

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

crontab -e
* * * * * [user] "echo 'hello' >> log"

######## Colab users / files

mkdir /[dir-path]
chown :[name-group] [dir-path]
chmod ug+w [dir-path]
chmod 027 [dir-path]

######## NTP

timedatectl set-timezone "americas/new_york"
timedatectl set-ntp true

dnf install -y chrony
vi /etc/chroney.conf
systemctl start chronyd
systemctl enable chronyd

######## AutoFS





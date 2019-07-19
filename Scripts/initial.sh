#!/bin/bash

yum install httpd httpd-tools
yum install ftp vsftpd

mkdir /etc/httpd/sites-available
mkdir /etc/httpd/sites-enabled

touch /home/user_domain
touch /home/user_email
touch /home/user_passwd
touch /home/user_volume

echo "IncludeOptional sites-enabled/*.conf" >> /etc/httpd/conf/httpd.conf
setsebool -P httpd_unified 1


echo "
anonymous_enable=NO

local_enable=YES

write_enable=YES

local_umask=022

dirmessage_enable=YES

xferlog_enable=YES

connect_from_port_20=YES

xferlog_std_format=YES


chroot_local_user=YES
allow_writeable_chroot=YES

listen=NO

listen_ipv6=YES

pam_service_name=vsftpd

userlist_enable=YES
userlist_file=/etc/vsftpd/user_list
userlist_deny=NO

tcp_wrappers=YES

user_sub_token=$USER
local_root=/home/$USER/ftp

pasv_min_port=30000
pasv_max_port=31000

#rsa_cert_file=/etc/vsftpd/vsftpd.pem
#rsa_private_key_file=/etc/vsftpd/vsftpd.pem
#ssl_enable=YES" > /etc/vsftpd/vsftpd.conf





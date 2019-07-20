#!/bin/bash

username=$1
oldal=$2
newal=$3
domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)


sed -i "s|ServerAlias\s$oldal|ServerAlias $newal\n|g" /etc/httpd/sites-available/$domain.conf
sed -i "s|$oldal|$newal|g" /etc/hosts


systemctl restart httpd
systemctl restart vsftpd


#!/bin/bash

userdel -r $1
domain=$(grep -i "($1:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
echo $domain

rm -rf /var/www/$domain
rm /etc/httpd/sites-available/$domain.conf
rm /etc/httpd/sites-enabled/$domain.conf
unlink /etc/httpd/sites-enabled/$domain.conf

grep -v "\s$domain" /etc/hosts > tmp
echo $(cat tmp)
cat tmp > /etc/hosts

grep -v "^($1:$domain)$" /home/user_domain > tmp
echo $(cat tmp)
cat tmp > /home/user_domain

grep -v "^$1$" /etc/vsftpd.userlist > tmp
echo $(cat tmp)
cat tmp > /etc/vsftpd.userlist


#!/bin/bash

userdel -r $1
domain=$(grep -i "($1:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
email=$(grep -i "($1:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
volume=$(grep -i "($1:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($1:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)



rm -rf /var/www/$domain
rm /etc/httpd/sites-available/$domain.conf
rm /etc/httpd/sites-enabled/$domain.conf
rm -rf /home/$1

grep -v "\s$domain" /etc/hosts > tmp
cat tmp > /etc/hosts

grep -v "^($1:$domain)$" /home/user_domain > tmp
cat tmp > /home/user_domain
grep -v "^($1:$email)$" /home/user_email > tmp
cat tmp > /home/user_domain
grep -v "^($1:$volume)$" /home/user_volume > tmp
cat tmp > /home/user_domain
grep -v "^($1:$passwd)$" /home/user_passwd > tmp
cat tmp > /home/user_domain

grep -v "^$1$" /etc/vsftpd/user_list > tmp
cat tmp > /etc/vsftpd/user_list

rm /etc/ssl/$domain.key
rm /etc/ssl/$domain.crt


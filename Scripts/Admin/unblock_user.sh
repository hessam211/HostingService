#!/bin/bash

username=$1


domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($username:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)


echo -e "$passwd\n$passwd" | passwd $username

sed -i "s|Redirect\s/\shttp://redirect.com||g" /etc/httpd/sites-available/$domain.conf



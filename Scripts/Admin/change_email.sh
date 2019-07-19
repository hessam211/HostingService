#!/bin/bash

username=$1
newemail=$2

domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
oldemail=$(grep -i "($username:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
volume=$(grep -i "($username:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($username:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)

sed -i "s|ServerAdmin\s$oldemail|ServerAdmin $newemail|g" /etc/httpd/sites-available/$domain.conf
sed -i "s|($username,$oldemail)|($username,$newemail)|g" /home/user_email

systemctl restart httpd

#!/bin/bash

userdel -r $1
domain=$(grep -i "($1:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)

rm -rf /var/www/$domain
rm /etc/httpd/sites-available/$domain.conf


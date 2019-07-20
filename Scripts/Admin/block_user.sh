#! /bin/bash

username=$1

domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)


RANGE=500
number=$RANDOM
let "number %= $RANGE"

echo -e "$number\n$number" | passwd $username


sed -i "s|DocumentRoot\s/var/www/$domain|DocumentRoot /var/www/$domain\n\tRedirect / http://redirect\n|g" /etc/httpd/sites-available/$domain.conf


systemctl restart httpd
systemctl restart vsftpd









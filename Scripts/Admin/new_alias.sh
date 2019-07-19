#!/bin/bash

username=$1
al=$2
domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)


sed -i "s|ServerName\s$domain|ServerName $domain\n\tServerAlias $al\n|g" /etc/httpd/sites-available/$domain.conf

echo "127.0.0.1        $al" >> /etc/hosts

systemctl restart httpd

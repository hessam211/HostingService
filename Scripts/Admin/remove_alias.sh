#!/bin/bash

username=$1
al=$2
domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)


sed -i "s|ServerAlias\s$al||g" /etc/httpd/sites-available/$domain.conf

sed -i "s|127.0.0.1\t$al||g" /etc/hosts


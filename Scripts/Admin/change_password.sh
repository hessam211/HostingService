#! /bin/bash

username=$1
newpasswd=$2
domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
email=$(grep -i "($username:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
volume=$(grep -i "($username:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)


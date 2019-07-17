#! /bin/bash

new=$1
old=$2
domain=$(grep -i "($old:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($old:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)
email=$(grep -i "($old:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
volume=$(grep -i "($old:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)

./delete_user.sh $old
./add_suer.sh $domain $new $passwd $email $volume


#! /bin/bash 

username=$1
newvolume=$2

domain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
email=$(grep -i "($username:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
oldvolume=$(grep -i "($username:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($username:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)

setquota -u -F vfsv1  $username 1 $newvolume 0 0 /
setquota -u -F vfsv1  $username -T 60 60 /

sed -i "s|($username,$oldvolume)|($username,$newvolume)|g" /home/user_volume

systemctl restart httpd

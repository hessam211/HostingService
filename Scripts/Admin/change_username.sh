#! /bin/bash

new=$1
old=$2
domain=$(grep -i "($old:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
email=$(grep -i "($old:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
volume=$(grep -i "($old:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($old:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)

usermod -l $new -d /home/$new -m $old


grep -v "^($old:$domain)$" /home/user_domain > tmp
cat tmp > /home/user_domain
echo "($new,$domain)" >> /home/user_domain

grep -v "^$old$" /etc/vsftpd.userlist > tmp
cat tmp > /etc/vsftpd.userlist
echo "$new" >> /etc/vsftpd.userlist

grep -v "^($old:$email)$" /home/user_email > tmp
cat tmp > /home/user_email
echo "($new,$email)" >> /home/user_email

grep -v "^($old:$passwd)$" /home/user_passwd > tmp
cat tmp > /home/user_passwd
echo "($new,$passwd)" >> /home/user_passwd


grep -v "^($old:$volume)$" /home/user_volume > tmp
cat tmp > /home/user_volume
echo "($new,$volume)" >> /home/user_volume


userDir='/var/www/'
rootDir=$userDir$domain
chown $new:users $rootDir
chmod 775 $rootDir

chown $new:users /home/$new
chmod 775 /home/$new



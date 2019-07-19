#!/bin/bash

username=$1
newdomain=$2

olddomain=$(grep -i "($username:" < /home/user_domain | cut -d ":" -f 2 | cut -d ")" -f 1)
email=$(grep -i "($username:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)
volume=$(grep -i "($username:" < /home/user_volume | cut -d ":" -f 2 | cut -d ")" -f 1)
passwd=$(grep -i "($username:" < /home/user_passwd | cut -d ":" -f 2 | cut -d ")" -f 1)

sed -i "s|127.0.0.1\t$olddomain|127.0.0.1\t$newdomain|g" /etc/hosts 

sed -i "s|($username:$olddomain)|($username:$newdomain)|g" /home/user_domain 

sed -i "s|ServerName\s$olddomain|ServerName $newdomain|g" /etc/httpd/sites-available/$olddomain.conf 

sed -i "s|<Directory\s/var/www/$olddomain>|<Directory /var/www/$newdomain>|g" /etc/httpd/sites-available/$olddomain.conf 

sed -i "s|DocumentRoot\s/var/www/$olddomain|DocumentRoot /var/www/$newdomain|g" /etc/httpd/sites-available/$olddomain.conf 

if [ -f /etc/ssl/$olddomain.crt ] ;
then
	sed -i "s|SSLCertificateFile\s/etc/ssl/$olddomain.crt|SSLCertificateFile /etc/ssl/$newdomain.crt|g" /etc/httpd/sites-available/$olddomain.conf 
	sed -i "s|SSLCertificateKeyFile\s/etc/ssl/$olddomain.key|SSLCertificateKeyFile /etc/ssl/$newdomain.key|g" /etc/httpd/sites-available/$olddomain.conf 
	mv /etc/ssl/$olddomain.key /etc/ssl/$newdomain.key
	mv /etc/ssl/$olddomain.crt /etc/ssl/$newdomain.crt

fi

mv -v /etc/httpd/sites-available/$olddomain.conf /etc/httpd/sites-available/$newdomain.conf
rm /etc/httpd/sites-enabled/$olddomain.conf
ln -s /etc/httpd/sites-available/$newdomain.conf /etc/httpd/sites-enabled/$newdomain.conf
mv -v /var/www/$olddomain /var/www/$newdomain

systemctl restart httpd

#!/bin/bash

domain=$1

email=$(grep -i "($username:" < /home/user_email | cut -d ":" -f 2 | cut -d ")" -f 1)


if [ -f /etc/httpd/sites-available/$domain.conf ];
then 

	echo -e "98\nisf\nisf\niut\nhesja68\nhesja68\njamshidianm98@gmail.com\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/$domain.key -out /etc/ssl/$domain.crt
	echo "
	<VirtualHost *:443>

		ServerName $domain
		ServerAlias $domain
		DocumentRoot /var/www/$domain
		<Directory /var/www/$domain>
			Options Indexes FollowSymLinks MultiViews
			AllowOverride all
			Require all granted
		</Directory>
		SSLEngine ON
		SSLCertificateFile /etc/ssl/$domain.crt
		SSLCertificateKeyFile /etc/ssl/$domain.key
	</VirtualHost>" >> /etc/httpd/sites-available/$domain.conf

fi 

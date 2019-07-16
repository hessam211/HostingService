#!/bin/bash

adduser $2 -m 
echo -e "$3\n$3" | passwd $2
usermod -aG users $2
setquota -u $2 $5 $5 $5 $5 /home
domain=$1
email=$4
sitesEnabled='/etc/httpd/sites-enabled/'
sitesAvailable='/etc/httpd/sites-available/'
userDir='/var/www/'
sitesAvailabledomain=$sitesAvailable$domain.conf

### don't modify from here unless you know what you are doing ####

if [ "$(whoami)" != 'root' ]; then
	echo $"You have no permission to run $0 as on-root user. Use sudo"
		exit 1;
fi


while [ "$domain" == "" ]
do
	echo -e $"Please provide domain. e.g.dev,staging"
	read domain
done


### if root dir starts with '/', don't use /var/www as default starting point
rootDir=$userDir$1


### check if domain already exists
if [ -e $sitesAvailabledomain ]; then
	echo -e $"This domain already exists.\nPlease Try Another one"
	exit;
fi

### check if directory exists or not
if ! [ -d $rootDir ]; then
	### create the directory
	mkdir $rootDir
	### give permission to root dir
	chmod 755 $rootDir
	### write test file in the new domain dir
	if ! echo "<?php echo phpinfo(); ?>" > $rootDir/phpinfo.php
	then
		echo $"ERROR: Not able to write in file $rootDir/phpinfo.php. Please check permissions"
		exit;
	else
		echo $"Added content to $rootDir/phpinfo.php"
	fi
fi

### create virtual host rules file
if ! echo "
<VirtualHost *:80>
	ServerAdmin $email
	ServerName $domain
	ServerAlias $domain
	DocumentRoot $rootDir
	<Directory />
		AllowOverride All
	</Directory>
	<Directory $rootDir>
		Options Indexes FollowSymLinks MultiViews
		AllowOverride all
		Require all granted
	</Directory>

</VirtualHost>" > $sitesAvailabledomain

then
	echo -e $"There is an ERROR creating $domain file"
	exit;
else
	echo -e $"\nNew Virtual Host Created on http protocol\n"
fi



### Add domain in /etc/hosts
if ! echo "127.0.0.1	$domain" >> /etc/hosts
then
	echo $"ERROR: Not able to write in /etc/hosts"
	exit;
else
	echo -e $"Host added to /etc/hosts file \n"
fi

mkdir /home/$2/ftp
chown $2:users /home/$2/ftp
chmod 755 /home/$2/ftp
mkdir /home/$2/ftp/files
chown $2:users /home/$2/ftp/files

if ! echo "$1" | sudo tee -a /etc/vsftpd.userlist
then
	echo $"ERROR: Not able to write in /etc/vsftpd.userlist"
	exit;
else
	echo -e $"user added to /etc/vsftpd.userlist ftp access \n"
fi


iam=$(whoami)
if [ "$iam" == "root" ]; then
	chown -R $2:users $rootDir
else
	chown -R $iam:users $rootDir
fi



### restart Apache
systemctl restart httpd
systemctl restart vsftpd

### show the finished message
echo -e $"Complete! \nYou now have a new Virtual Host \nYour new host is: http://$domain \nAnd its located at $rootDir"
exit;


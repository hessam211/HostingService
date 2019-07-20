#!/bin/bash

adduser $1 -m 
echo -e "$2\n$2" | passwd $1
usermod -aG root $1
usermod -aG sudo $1

echo "
alias chuser='/home/mahya/HostingService/Script/Admin/change_user.sh'

alias adduser='/home/mahya/HostingService/Script/Admin/add_user.sh'

alias deluser='/home/mahya/HostingService/Script/Admin/delete_user.sh'

alias chdomain='/home/mahya/HostingService/Script/Admin/change_domain.sh'

alias chpasswd='/home/mahya/HostingService/Script/Admin/change_password.sh'

alias chemail='/home/mahya/HostingService/Script/Admin/change_email.sh'

alias chvolume='/home/mahya/HostingService/Script/Admin/change_volume.sh'

alias chemail='/home/mahya/HostingService/Script/Admin/change_email.sh'

alias blockuser='/home/mahya/HostingService/Script/Admin/block_user.sh'

alias unblockuser='/home/mahya/HostingService/Script/Admin/unblock_user.sh'

alias addadmin='/home/mahya/HostingService/Script/Admin/add_admin.sh'

alias makessl='/home/mahya/HostingService/Script/Admin/make_ssl.sh'

alias listuser='/home/mahya/HostingService/Script/Admin/list_group_user.sh'

alias chemail='/home/mahya/HostingService/Script/Admin/change_email.sh'

alias newal='/home/mahya/HostingServie/Scripts/new_alias.sh'

alias removeal='/home/mahya/HostingServie/Scripts/remove_alias.sh'

alias edital='/home/mahya/HostingServie/Scripts/edit_alias.sh'

" >> /home/$1/.bashrc



echo "Admin added"

systemctl restart httpd
systemctl restart vsftpd

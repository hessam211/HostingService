#!/bin/bash

adduser $1 -m 
echo -e "$2\n$2" | passwd $1
usermod -aG root $1

echo "Admin added"

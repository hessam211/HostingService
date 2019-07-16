#!/bin/bash

egrep -i "^$1:" /etc/passwd;
if [ $? -eq 0 ]; then
   echo "User Exists"
else
   echo "User does not exist"
fi

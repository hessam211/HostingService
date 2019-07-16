#!/bin/bash

egrep -i "^$1:" /etc/passwd;
if [ $? -eq 0 ]; then
   echo "YES"
else
   echo "NO"
fi

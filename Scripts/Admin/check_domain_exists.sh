#!/bin/bash

grep -q " $1" /etc/hosts;
if [ $? -eq 0 ]; then
   echo "Domain Exists"
else
   echo "Domain does not exist"
fi

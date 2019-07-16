#!/bin/bash


srchGroup="$1"


for thisLine in "`grep "^${srchGroup}:" /etc/group`"
do
  grpUsers="`echo ${thisLine} | cut -d":" -f4 | sed 's/,/ /g'`"
done

echo "${grpUsers}"  # from /etc/group


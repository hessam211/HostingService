#! /bin/bash

username=$1

RANGE=500
number=$RANDOM
let "number %= $RANGE"

echo -e "$number\n$number" | passwd $username





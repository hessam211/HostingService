#!/bin/bash

result="$(cracklib-check <<<"$1")"

okay="$(awk -F': ' '{ print $2}' <<<"$result")"
if [[ "$okay" == "OK" ]]
then
	echo $okay
	
else
	echo "Your password was rejected - $result"
        echo "Try again."
fi

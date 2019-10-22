#! /bin/bash

for directory in $(echo $PATH | sed 's/:/ /g')
do
	if [ -x "$directory/$1" ]
	then echo "$directory/$1"; exit 0
	fi
done
exit 1

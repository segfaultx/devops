#! /bin/bash
LOGIN=false
while true
do
	if [ -n $(who | grep $1) ] && [ LOGIN = false ]; then
	       	echo "Hallo, $1"; LOGIN=true
	fi
	if [ -z $( who | grep $1) ] && [ LOGIN = true ]; then 
		echo "Tschüss, $1"
	fi
	sleep 5
done
exit 0

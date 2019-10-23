#! /bin/bash

BAD_PROCESSES=$(echo "$*" | sed "s/ /|/g");
while true
do
    kill $(ps auxw | egrep "($LOGNAME.*($BAD_PROCESSES))" | tr -s " " | cut -d" " -f2 | sed "s/$$//g") 2>/dev/null
    sleep 10
done
exit 0
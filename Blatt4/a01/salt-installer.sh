#!/bin/bash

if [ $# -g 1 ];then
	exit -1
fi

apt install gnupg -y
wget -O - https://repo.saltstack.com/py3/debian/10/amd64/latest/SALTSTACK-GPG-KEY.pub | apt-key add -
echo "deb http://repo.saltstack.com/py3/debian/10/amd64/latest buster main" > /etc/apt/sources.list.d/saltstack.list
apt update


if [ $1 = "master" ]; then
	apt install salt-master -y
else
	apt install salt-minion -y
	systemctl stop salt-minion
	cat /etc/salt/minion | sed "s/#master: salt/master: $1/" > out && mv out minion && mv minion /etc/salt/
	systemctl restart salt-minion
fi

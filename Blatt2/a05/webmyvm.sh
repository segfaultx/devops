#!/bin/bash

install_webserver() {
	apt update
	apt install lighttpd -y
	lighty-enable-mod cgi
	sed "s|\"\" => \"\"|\".py\" => \"/usr/bin/python3\", \"\" => \"\"|" /etc/lighttpd/conf-enabled/10-cgi.conf >out.conf &&
		rm /etc/lighttpd/conf-enabled/10-cgi.conf &&
		mv out.conf 10-cgi.conf &&
		mv 10-cgi.conf /etc/lighttpd/conf-enabled/10-cgi.conf
	service lighttpd force-reload
}
check_installation() {
	local INSTALLED=$(dpkg -l | grep 'lighttpd' | wc -l)
	echo $INSTALLED
}

update_application() {
	DIR=$(ls -d */)
	mkdir /var/www/html/$1
	mkdir /usr/lib/cgi-bin/$1
	mv $DIR/html/* /var/www/html/$1
	mv $DIR/cgi-bin/* /usr/lib/cgi-bin/
}
destroy_webserver() {
	rm -rf /var/www/html/*
	rm -rf /usr/lib/cgi-bin/
	rm -rf /etc/lighttpd
	apt purge lighttpd -y
	apt autoremove -y
	rm -rf $(ls ~)
}
if [ $# -eq 0 ]; then
	exit 1
fi

if test $1 = "install"; then
	if [ $(check_installation) -eq 0 ]; then
		install_webserver
	fi
	update_application $2
	exit 0
fi
if test $1 = "destroy"; then
	destroy_webserver
	exit 0
fi
if [ $# -eq 2 ]; then
	ssh -J login1 root@$1 "apt update && apt install rsync -y"
	rsync -azv -e 'ssh -A -J amusc001@login1.mi.hs-rm.de' * root@$1:~
	if test $2 = "destroy"; then
		ssh -J login1 root@$1 "./webmyvm.sh destroy"
		exit 0
	fi
	ssh -J login1 root@$1 "./webmyvm.sh install $2"
	exit 0
fi

exit 1

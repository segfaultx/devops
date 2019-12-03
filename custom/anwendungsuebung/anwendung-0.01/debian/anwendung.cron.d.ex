#
# Regular cron jobs for the anwendung package
#
0 4	* * *	root	[ -x /usr/bin/anwendung_maintenance ] && /usr/bin/anwendung_maintenance

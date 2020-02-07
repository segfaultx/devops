lighttpd:
  pkg:
    - installed
  service.running:
    - name: lighttpd
    - enable: True
    - reload: True
    - watch:
      - file: /etc/lighttpd/lighttpd.conf

dh-make:
  pkg:
    - installed

/etc/lighttpd/lighttpd.conf:
  file.managed:
    - template: jinja
    - source: salt://{{slspath}}/lighttpd.conf
    - defaults:
      webdir: /var/www/html
      webuser: www-data
      webgroup: www-data

webuser:
  user.present:
    - name: {{pillar.webuser | default("www-data")}}

webgroup:
  group.present:
    - name: {{pillar.webgroup | default("www-data")}}

{{pillar.webdir}}:
  file.directory:
    - user: {{pillar.webuser | default("www-data")}}
    - mode: 766

/usr/bin/update-packages-index.sh:
  file.managed:
    - source: salt://{{slspath}}/update-packages-index.sh
    - mode: 744

/var/www/html/packages:
  file.directory:
    - user: www-data
    - name: /var/www/html/packages
    - mode: 766

/usr/bin/update-packages-index.sh /var/www/html/packages:
  cron.present:
    - user: root
    - minute: '*/2'


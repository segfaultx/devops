nexususer:
  user.present:
    - name: nexus

nexusgroup:
  group.present:
    - name: nexus

java8.list:
  pkgrepo.managed:
    - humanname: adoptopenjdk repository
    - name: deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main Release
    - dist: buster
    - key_url: https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public
    - file: /etc/apt/sources.list.d/adoptopenjdk.list

adoptopenjdk-8-hotspot-jre:
  pkg:
    - installed

extract_nexus3:
  archive.extracted:
    - name: /srv/nexus-home/
    - source: https://download.sonatype.com/nexus/3/latest-unix.tar.gz
    - source_hash: 911020eeed09530c52cdccea78278020

/srv/nexus-home/:
  file.directory:
    - user: nexus
    - group: nexus
    - mode: 744
    - recurse:
      - user
      - group

/etc/systemd/system/nexus.service:
  file.managed:
    - source: salt://{{slspath}}/nexus.service

nexus.service:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - file: /etc/systemd/system/nexus.service

# Nexus aufsetzen

nexus3:
    user.present:
        - name: nexus
    group.present:
        - name: nexus

apt.repo:
    pkgrepo.managed:
        - humanname: AdoptOpenJDK
        - name: deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb/ buster main Release
        - dist: buster
        - file: /etc/apt/sources.list.d/apt.list
        - key_url: https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public

jdk8.packages:
    pkg.installed:
        - fromrepo: buster
        - pkgs:
            - adoptopenjdk-8-hotspot-jre

extract_nexus3:
    archive.extracted:
        - name: /srv/nexus-home
        - source: https://download.sonatype.com/nexus/3/latest-unix.tar.gz
        - source_hash: 33121c338aa3e232a16156ad8edaa168aeb2f52c

/srv/nexus-home:
    file.directory:
        - user: nexus
        - owner: nexus
        - group: nexus
        - dir_mode: 777
        - file_mode: 777
        - recurse:
            - user
            - group
            - mode

/etc/systemd/system/nexus.service:
    file.managed:
        - source: salt://{{slspath}}/nexus.service
        - mode: 644
        
nexus.service:
    service.running:
        - name: nexus.service
        - enable: True

prometheus-node-exporter:
  pkg:
    - installed

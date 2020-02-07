prometheus:
  pkg:
    - installed
  service.running:
    - name: prometheus.service
    - enable: True
    - reload: True
    - watch:
        - file: /etc/prometheus/prometheus.yml

/etc/prometheus/prometheus.yml:
  file.managed:
    - source: salt://{{slspath}}/prometheus.yml
    - mode: 644

apt-transport-https:
  pkg:
    - installed

software-properties-common:
  pkg:
    - installed

apt.repo:
  pkgrepo.managed:
    - humanname: Grafana
    - name: deb https://packages.grafana.com/oss/deb stable main
    - dist: stable
    - key_url: https://packages.grafana.com/gpg.key

grafana:
  pkg:
    - installed
  service.running:
    - name: grafana-server
    - enable: True
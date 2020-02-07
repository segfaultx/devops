/etc/apt/sources.list.d/reposerver.list:
  file.managed:
    - source: salt://{{slspath}}/myrepo.list
    - mode: 644

gnupg:
    pkg.installed

saltstack.list:
    pkgrepo.managed:
    - humanname: Saltstack repo
    - name: deb http://repo.saltstack.com/py3/debian/10/amd64/latest buster main
    - dist: buster
    - key_url: https://repo.saltstack.com/py3/debian/10/amd64/latest/SALTSTACK-GPG-KEY.pub
    - file: /etc/apt/sources.list.d/saltstack.list

salt-minion:
    pkg:
        - installed
    service.running:
        - name: salt-minion
        - enable: True

'systemctl restart salt-minion':
    cmd.run:
        - watch:
            - file: /etc/salt/minion

/etc/salt/minion:
    file.line:
        - name: /etc/salt/minion
        - match: "#master: salt"
        - mode: replace
        - content: "master: devops0301.intern.mi.hs-rm.de"


gnupg:
    pkg:
        - installed

saltstack.list:
    pkgrepo.managed:
        - humanname: saltstackrepo
        - name: deb http://repo.saltstack.com/py3/debian/10/amd64/latest buster main
        - dist: buster 
        - file: /etc/apt/sources.list.d/saltstack.list
        - key_url: https://repo.saltstack.com/py3/debian/10/amd64/latest/SALTSTACK-GPG-KEY.pub

salt-minion:
    pkg:
        - installed

/etc/salt/minion:
    file.line:
        - name: /etc/salt/minion
        - mode: replace
        - content: "master: devops0304.intern.mi.hs-rm.de"
        - match: "#master: salt"

"systemctl restart salt-minion":
    cmd.run:
        - watch: 
            - file: /etc/salt/minion


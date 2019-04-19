{% set Dns1='192.168.10.1'%}
{% set Dns2='8.8.8.8'%}
dns-init:
  file.managed:
    - name: /etc/resolv.conf
    - source: salt://init/file/resolv.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      dns1: {{Dns1}}
      dns2: {{Dns2}}




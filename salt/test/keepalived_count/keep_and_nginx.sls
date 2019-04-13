{% set RoutId='nginx'%}
{% set StateData1='MASTER'%}
{% set StateData2='BACKUP'%}
{% set DevNet1='ens33'%}
{% set DevNet2='eth0'%}
{% set Pid1='100'%}
{% set Pid2='150'%}
{% set Vip='192.168.10.245/24'%}

include:
  - keepalived.keepalived-install
  - nginx.nginx
keep_and_nginx_conf_file:
  file.managed:
    - name: /etc/keepalived/keepalived.conf
    - source: salt://keepalived_count/file/keepalived-nginx.conf
    - user: root
    - group: root
    - mode: 644
    - template: jinja
{% if grains['ipv4'][1]=='192.168.10.80'%}
    - routid: {{RoutId}}
    - statedata: {{StateData1}}
    - devnet: {{DevNet1}}
    - pid: {{Pid1}}
    - vip: {{Vip}}
{% elif grains['ipv4'][1]!='192.168.10.20'%}
    - routid: {{RoutId}}
    - statedata: {{StateData2}}
    - devnet: {{DevNet2}}
    - pid: {{Pid2}}
    - vip: {{Vip}}
{% endif %}
    - unless: test -f /etc/keepalived/keepalived.conf
  service.running:
    - name: keepalived
    - enable: True
    - require: 
      - file: keep_and_nginx_conf_file


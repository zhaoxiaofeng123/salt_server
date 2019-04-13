include:
  - cobbler.cobbler-pki-init
#在/etc/cobbler/settings中的server  ,next_server, dhcp管理字段
{% set Ip1='192.168.10.80'%}
{% set Ip2='192.168.10.80'%}
{% set Cdhcp='1'%}
#在/etc/cobbler/dhcp.template中的dhcp模板的配置

#表示网络段
{% set  DhcpNet='192.168.10.0'%}
#表示掩码
{% set NetMask='255.255.255.0'%}
#表示dns
{% set Dns='192.168.10.1'%}
#表示可分配的ip
{% set Dhcp_range='192.168.10.200 192.168.10.240'%}
cobbler-conf:
  file.managed:
    - name: /etc/cobbler/settings
    - source: salt://cobbler/file/settings
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      ip1: {{Ip1}}
      ip2: {{Ip2}}
      cdhcp: {{Cdhcp}}
  cmd.run:
    - name: systemctl start httpd &&  systemctl start cobblerd  && systemctl start rsyncd && systemctl enable httpd &&  systemctl enable cobblerd  && systemctl enable rsyncd && cobbler get-loaders

init-tftp:
  file.managed:
    - name: /etc/xinetd.d/tftp
    - source: salt://cobbler/file/tftp
    - user: root
    - group: root
    - mode: 644
  service.running:
    - name: tftp
    - enable: True
    - watch:
      - file: init-tftp
dhcp-conf:
  file.managed:
    - name: /etc/cobbler/dhcp.template
    - source: salt://cobbler/file/dhcp.template
    - user: root
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      ipnet: {{DhcpNet}}
      netmask: {{NetMask}}
      dnsip: {{Dns}}
      iprange: {{Dhcp_range}}
  cmd.run:
    - name: systemctl start httpd && systemctl start cobblerd && cobbler sync
    - watch:
      - file: dhcp-conf

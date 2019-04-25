{% set UserName='mycat'%}
{% set PassWd='123456'%}
{% set DataBase='test'%}
{% set MasterWUrl='192.168.10.121:3306'%}
{% set MasterWUser='root1'%}
{% set MasterWPwd='123456'%}
{% set MasterRUrl='192.168.10.131:3306'%}
{% set MasterRUser='root1'%}
{% set MasterRPwd='123456'%}
{% set SlaveWUrl='192.168.10.131:3306'%}
{% set SlaveWUser='root1'%}
{% set SlaveWPwd='123456'%}
{% set SlaveRUrl='192.168.10.121:3306'%}
{% set SlaveRUser='root1'%}
{% set SlaveRPwd='123456'%}
mycat-copy-file:
  pkg.installed:
    - names:
      - java-1.8.0-openjdk
  file.managed:
    - name: /root/Mycat-server-1.6.5-release-20180122220033-linux.tar.gz
    - source: salt://mycat/file/Mycat-server-1.6.5-release-20180122220033-linux.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root && tar zxvf Mycat-server-1.6.5-release-20180122220033-linux.tar.gz && cp -a /root/mycat  /usr/local/mycat && useradd -s /sbin/nologin  -M  mycat   &&  chown -R mycat.mycat  /usr/local/mycat 
    - unless: test -d /usr/local/mycat
    - require: 
      - file: mycat-copy-file
copy-server-xml:
  file.managed:
    - name: /usr/local/mycat/conf/server.xml
    - source: salt://mycat/file/server.xml
    - user: mycat
    - group: mycat
    - mode: 644
    - template: jinja
    - defaultes:
      username: {{UserName}}
      passwd: {{PassWd}}
    - require:
      - cmd: mycat-copy-file
copy-schema-xml:
  file.managed:
    - name: /usr/local/mycat/conf/schema.xml
    - source: salt://mycat/file/schema.xml
    - user: mycat
    - group: mycat
    - mode: 644
    - template: jinja
    - defaults:
      database: {{DataBase}}
      masterwurl: {{MasterWUrl}}
      masterwuser: {{MasterWUser}}
      masterwpwd: {{MasterWPwd}}
      masterrurl: {{MasterRUrl}}
      masterruser: {{MasterRUser}}
      masterrpwd: {{MasterRPwd}}
      slavewurl: {{SlaveWUrl}}
      slavewuser: {{SlaveWUser}}
      slavewpwd: {{SlaveWPwd}}
      slaverurl: {{SlaveRUrl}}
      slaveruser: {{SlaveRUser}}
      slaverpwd: {{SlaveRPwd}}
    - require:
      - cmd: mycat-copy-file

include:
  - keepalived.init
keep-code-install:
  file.managed:
    - name: /root/Downloads/keepalived-1.2.19.tar.gz
    - source: salt://keepalived/file/keepalived-1.2.19.tar.gz
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /root/Downloads && tar zxvf keepalived-1.2.19.tar.gz && cd keepalived-1.2.19 && ./configure  --prefix=/usr/local/keepalived && make && make install
    - unless: test -d /usr/local/keepalived
    - require:
      - file: keep-code-install

/etc/sysconfig/keepalived:
  file.managed:
    - source: salt://keepalived/file/keepalived.sysconfig
    - user: root
    - group: root
    - mode: 644
keep-init-file:
  file.managed:
    - name: /etc/init.d/keepalived
    - source: salt://keepalived/file/keepalived.init
    - root: root
    - group: root
    - mode: 755
create-conf-dir:
  file.directory:
    - name: /etc/keepalived
    - user: root
    - group: root
    - mode: 755
    - unless: test -d /etc/keepalived
add-sys-init:
  cmd.run:
    - name: chkconfig --add keepalived
    - unless: chkconfig --list|grep keepalived
    - requirt:
      - file: keep-init-file
      - cmd: keep-code-install

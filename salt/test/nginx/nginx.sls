{% set NginxName='nginx-1.6.3'%}
include:
  - nginx.init
nginx-user-test:
  cmd.run:
    - name: useradd nginx -s /sbin/nologin
    - unless: id  nginx
nginx-install:
  file.managed:
    - name: /root/Downloads/{{NginxName}}.tar.gz
    - source: salt://nginx/file/{{NginxName}}.tar.gz
    - user: root
    - group: root
    - mode: 755

  cmd.run:
    - name: cd /root/Downloads && tar zxvf  {{NginxName}}.tar.gz && cd {{NginxName}} && ./configure --prefix=/usr/local/nginx  --user=nginx --group=nginx --with-http_ssl_module --with-http_stub_status_module && make && make install
    - unless: test -d  /usr/local/nginx
    - require:
      - file: nginx-install
      - cmd: nginx-user-test
nginx-config:
  file.managed:
    - name: /usr/local/nginx/conf/nginx.conf
    - source: salt://nginx/file/nginx.conf
    - user: nginx
    - group: nginx
    - mode: 644
    - require:
      - cmd: nginx-install

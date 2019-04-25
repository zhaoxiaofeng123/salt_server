{% set Host1='192.168.10.80'%}
{% set Host2='192.168.10.20'%}
{% set Port1='8080'%}
{% set Port2='8080'%}
varnish-init:
  pkg.installed:
    - names:
      - pcre
      - make 
      - autoconf
      - automake
      - jemalloc-devel
      - libedit-devel
      - libtool
      - ncurses-devel
      - pcre-devel
      - pkgconfig
      - python-docutils
      - python-sphinx
  file.managed:
    - name: /root/varnish-5.2.1.tgz
    - source: salt://varnish/file/varnish-5.2.1.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root && tar zxvf varnish-5.2.1.tgz  && cd varnish-5.2.1 && sh autogen.sh && ./configure  --prefix=/usr/local/varnish && make && make install && ldconfig && ln -s -f  /usr/local/varnish/sbin/varnishd    /usr/local/sbin/varnishd  
    - unless: test -d /usr/local/varnish
    - require: 
      - file: varnish-init
varnish-conf-copy:
  file.managed:
    - name: /usr/local/varnish/example.vcl
    - source: salt://varnish/file/example.vcl
    - user: root
    - group: root
    - mode: 644
    - template: jinja 
    - defaults:
      host1: {{Host1}}
      port1: {{Port1}}
      host2: {{Host2}}
      port2: {{Port2}}
    - require:
      - cmd: varnish-init
  cmd.run:
    - name: varnishd  -f /usr/local/varnish/example.vcl -a :80  -s malloc,1G -t 60

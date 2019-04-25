{% set File='/www'%}
php-init:
  file.managed:
    - name: /root/mysql-community-libs-compat-5.7.22-1.el7.x86_64.rpm
    - source: salt://php/yum-install/file/mysql-community-libs-compat-5.7.22-1.el7.x86_64.rpm
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root &&   yum install -y php php-devel php-fpm php-mysql php-common php-devel php-gd libjpeg* php-imap php-ldap php-odbc php-pear php-xml php-xmlrpc php-mbstring php-mcrypt php-bcmath php-mhash libmcrypt libmcrypt-devel && systemctl start php-fpm &&  yum localinstall -y  mysql-community-libs-compat-5.7.22-1.el7.x86_64.rpm && yum install -y php-mysql && systemctl enable   php-fpm
    - require: 
      - file: php-init
apc-init:
  pkg.installed:
    - names:
      - gcc
      - gcc-c++
      - nginx
  file.managed:
    - name: /root/APC-3.1.9.tgz
    - source: salt://php/yum-install/file/APC-3.1.9.tgz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root && tar zxvf APC-3.1.9.tgz && cd APC-3.1.9/ && /usr/bin/phpize &&  ./configure --enable-apc --enable-apc-mmap --with-php-config=/usr/bin/php-config --prefix=/usr/local/apc && make && make install
    - require:
      - file: apc-init
php-ini-append:
  file.append:
    - name: /etc/php.ini
    - text: 
      - [apc]
      - extension="/usr/lib64/php/modules/apc.so"
      - apc.enabled = 1
      - apc.cache_by_default = on
      - apc.shm_segments = 1
      - apc.shm_size = 64
      - apc.ttl = 7200
      - apc.user_ttl = 7200
      - apc.num_files_hint = 0
      - apc.write_lock = On
nginx-init:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://php/yum-install/file/nginx.conf
    - user: root 
    - group: root
    - mode: 644
    - template: jinja
    - defaults:
      file: {{File}}
    - require:
      - pkg: apc-init
  cmd.run:
    - name: \cp -a   /root/APC-3.1.9/apc.php  /www   &&  chown -R nginx.nginx /www
    - require:
      - file: nginx-init

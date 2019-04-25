php-init:
  file.managed:
    - name: /root/php-7.2.11.tar.gz
    - source: salt://php/gz-install/file/php-7.2.11.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: yum -y install gcc gcc-c++ gcc-g77 make libtool autoconf patch unzip automake libxml2 libxml2-devel ncurses ncurses-devel libtool-ltdl-devel libtool-ltdl libmcrypt libmcrypt-devel libpng libpng-devel libjpeg-devel openssl openssl-devel gd-devel curl curl-devel libxml2 libxml2-devel ncurses ncurses-devel libtool-ltdl-devel libtool-ltdl autoconf automake libaio* && cd /root && tar zxvf php-7.2.11.tar.gz && cd php-7.2.11 &&./configure  --prefix=/usr/local/php7  --enable-fpm --with-mysql   && make && make install && cp sapi/fpm/php-fpm /usr/local/bin 
    - unless: test -d /usr/local/php7
php-file-copy:
  file.managed:
    - name: /usr/local/php7/lib/php.ini
    - source: salt://php/gz-install/file/php.ini
    - user: root
    - group: root
    - mode: 644
    - require:
      - cmd: php-init
  cmd.run:
    - name: useradd -s /sbin/nologin  -M www
    - unless: id www
php-fpm-file-copy:
  file.managed:
    - name: /usr/local/php7/etc/php-fpm.conf
    - source: salt://php/gz-install/file/php-fpm.conf
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: mkdir /var/log/php-fpm
    - unless: test -d /var/log/php-fpm
php-www-file-copy:
  file.managed:
    - name: /usr/local/php7/etc/php-fpm.d/www.conf
    - source: salt://php/gz-install/file/www.conf
    - user: root
    - group: root
    - mode: 644  

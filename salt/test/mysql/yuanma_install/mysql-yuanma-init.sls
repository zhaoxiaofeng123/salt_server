{% set  Port='3306' %}
rpm-init:
  file.directory:
    - name: /root/Downloads
    - user: root
    - group: root
    - dir_mode: 755
    - unless: test  -d /data/Downloads
  pkg.installed:
    - names:
      - gcc
      - gcc-c++
      - ncurses
      - ncurses-devel
      - cmake
      - perl
      - perl-devel
      - bison
boost-init:
  file.managed:
    - name: /root/Downloads/boost_1_59_0.tar.gz
    - source: salt://mysql/file/yuanma/boost_1_59_0.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root/Downloads/ && tar zxvf boost_1_59_0.tar.gz && cp -a boost_1_59_0 /usr/local/boost
    - unless: test -d  /usr/local/boost
    - require:
       - file: boost-init
mysql-init:
  file.managed:
    - name: /root/Downloads/mysql-5.7.23.tar.gz
    - source: salt://mysql/file/yuanma/mysql-5.7.23.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root/Downloads && tar zxvf mysql-5.7.23.tar.gz && cd /root/Downloads/mysql-5.7.23  && cmake -DCMAKE_INSTALL_PREFIX=/usr/local/mysql -DMYSQL_DATADIR=/usr/local/mysql/data -DWITH_BOOST=/usr/local/boost -DSYSCONFDIR=/etc -DWITH_INNOBASE_STORAGE_ENGINE=1 -DWITH_PARTITION_STORAGE_ENGINE=1 -DWITH_FEDERATED_STORAGE_ENGINE=1 -DWITH_BLACKHOLE_STORAGE_ENGINE=1 -DWITH_MYISAM_STORAGE_ENGINE=1 -DENABLED_LOCAL_INFILE=1 -DENABLE_DTRACE=0 -DDEFAULT_CHARSET=utf8 -DDEFAULT_COLLATION=utf8_general_ci -DWITH_EMBEDDED_SERVER=1  && make -j {{grains['num_cpus']}}  && make -j {{grains['num_cpus']}}  install
    - require:
      - file: mysql-init

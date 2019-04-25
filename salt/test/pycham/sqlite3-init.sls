core-init:
  file.directory:
    - name: /data
    - user: root
    - group: root
    - dir_mode: 755
    - file_mode: 644
    - unless: test -d /data
  cmd.run:
    - name: yum  install -y wget gcc gcc-c++ make zlib zlib-devel openssl openssl-devel bzip2-devel expat-devel gdbm-devel readline-devel sqlite-devel python36-devel libxml*
sql-init:
  file.managed:
    - name: /root/sqlite-3.5.6.tar.gz
    - source: salt://pycham/file/sqlite-3.5.6.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root  && tar zxvf sqlite-3.5.6.tar.gz && cd sqlite-3.5.6 && ./configure --disable-tcl --prefix="/data/software" >/dev/null && make -j  {{grains['num_cpus']}} >/dev/null && make -j {{grains['num_cpus']}} install >/dev/null
    - unless: test -d /data/software
    - require: 
      - file: sql-init
      - cmd: core-init

python-install:
  file.managed:
    - name: /root/Python-3.6.8.tgz
    - source: salt://pycham/file/Python-3.6.8.tgz
    - user: root
    - group: root
    - mode: 644
    - require:
      - file: core-init
  cmd.run:
    - name: cd /root && tar zxvf Python-3.6.8.tgz && cd Python-3.6.8 && ./configure LDFLAGS="-L/data/software/sqlite-3.5.6/lib" CPPFLAGS="-I/data/software/sqlite-3.5.6/include" --prefix="/data/python3" >/dev/null &&  make -j  {{grains['num_cpus']}} >/dev/null && make -j {{grains['num_cpus']}} install >/dev/null && ln -sf /data/python3/bin/python3.6 /usr/local/bin/python3
    - require:
      - file: python-install


mysql-file-and-init:
  file.managed:
    - name: /etc/my.cnf
    - source: salt://mysql/file/yuanma/my.cnf
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: useradd  -s /sbin/nologin -M mysql &&  chown -R mysql:mysql /usr/local/mysql  && /usr/local/mysql/bin/mysqld --initialize-insecure --user=mysql --basedir=/usr/local/mysql --datadir=/usr/local/mysql/data
    - require:
      - file: mysql-file-and-init

mysql-add-sys:
  file.append:
    - name: /etc/profile
    - text: PATH=$PATH:/usr/local/mysql/bin
    - require:
      - cmd: mysql-file-and-init
  cmd.run:
    - name: export PATH=$PATH:/usr/local/mysql/bin && cp -a /usr/local/mysql/support-files/mysql.server /etc/init.d/mysqld &&  chmod +x /etc/init.d/mysqld && chkconfig --add mysqld  && systemctl start mysqld && mysql -uroot -e "set password=password('root')" && systemctl restart mysqld  && systemctl enable mysqld

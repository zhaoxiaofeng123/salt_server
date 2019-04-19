mysql-install:
  pkg.installed:
    - name: mysql-community-server
    - unless: rpm -qa|grep mysql-community-server
  cmd.run:
    - name: cp -af  /etc/my.cnf  /etc/my.cnf.back
    - require:
      - pkg: mysql-install
  file.append:
    - name: /etc/my.cnf
    - text: skip-grant-tables
    - require: 
      - pkg: mysql-install
cmd-init:
  cmd.run:
    - name:  systemctl start mysqld && mysql -e "use mysql;update user set authentication_string=password('root') where user='root';flush privileges;"  && cp -af /etc/my.cnf.back /etc/my.cnf  && systemctl restart mysqld && mysql -uroot -proot -e "set global validate_password_policy=0;set global validate_password_length=1;SET PASSWORD = PASSWORD('root');flush privileges;"
    - require:
      - file: mysql-install
    

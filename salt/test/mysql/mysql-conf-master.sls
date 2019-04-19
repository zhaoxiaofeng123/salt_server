{% set Pid='10' %}
{% set DataBase='test'%}
mysql-master-conf:
  file.append:
    - name: /etc/my.cnf
    - text: 
      - log-bin=master{{Pid}}_log
      - binlog-do-db={{DataBase}}
      - log-slave-updates=1
      - relay_log={{DataBase}}-relay-bin
      - sync_binlog=1
      - server_id ={{Pid}}
  cmd.run:
    - name: systemctl restart mysqld && mysql -uroot -proot -e "set global validate_password_policy=0;set global validate_password_length=1;GRANT ALL  ON *.* TO 'root1'@'%' identified  by'123456'; flush privileges; show master status;">/root/Downloads/master{{Pid}}
    - require:
      - file: mysql-master-conf

{% set Pid='20' %}
{% set DataBase='test'%}
{% set my='192.168.10.131'%}
{% set master='192.168.10.121'%}
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
    - name: systemctl restart mysqld && export PATH=$PATH:/usr/local/mysql/bin && echo {{my}} >master.txt && mysql -uroot -proot -e "GRANT ALL  ON *.* TO 'root1'@'%' identified  by'123456'; flush privileges; show master status;" | tail -1 >>master.txt && scp master.txt root@{{master}}:/root/Downloads
    - require:
      - file: mysql-master-conf

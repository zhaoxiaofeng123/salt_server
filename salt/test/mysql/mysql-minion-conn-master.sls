{% set Master='192.168.10.121'%}
{% set Pid='2'%}
mysql-mini-conn:
  file.append:
    - name: /etc/my.cnf
    - text: server_id={{Pid}}
  cmd.run:
    - name: systemctl restart mysqld && mysql -uroot -proot -e "reset slave ; change master to    master_host='{{Master}}',master_user='root1',master_password='123456',master_log_file='master10_log.000001',master_log_pos=587; start slave"

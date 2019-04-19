link-master:
  cmd.run:
    - name:  systemctl restart mysqld && export PATH=$PATH:/usr/local/mysql/bin &&IP1=$(python -c "print(open('/root/Downloads/master.txt',mode='r').read().split())[0]") && FILE1=$(python -c "print(open('/root/Downloads/master.txt',mode='r').read().split())[1]") && ID1=$(python -c "print(open('/root/Downloads/master.txt',mode='r').read().split())[2]")&&mysql -uroot -proot -e "reset slave ; change master to    master_host='`echo $IP1`',master_user='root1',master_password='123456',master_log_file='`echo $FILE1`',master_log_pos=`echo $ID1`; start slave"

double-master-1.sls   rpm安装的mysql所使用的主主备份的模板
double-master-2.sls   yuanma安装的mysql所使用的主主备份的模板
以上两个模板都是将主库的配置文件发送给另一个主库，然后通过python解析得到想要的结果
minion-link-master.sls  从库映射主库

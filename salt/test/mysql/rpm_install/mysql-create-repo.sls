mysql_repo_init:
  file.managed:
    - name: /etc/yum.repos.d/mysql.repo
    - source: salt://mysql/file/mysql.repo
    - user: root
    - group: root
    - mode: 644
    - unless: test -f  /etc/yum.repos.d/mysql.repo
  cmd.run:
    - name: yum clean all && yum makecache
    - require:
      - file: mysql_repo_init

include:
  - pycham.sqlite3-init
setuptools-install:
  file.managed:
    - name: /root/setuptools-40.8.0.zip
    - source: salt://pycham/file/setuptools-40.8.0.zip
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root && unzip setuptools-40.8.0.zip && cd setuptools-40.8.0 &&  python setup.py install
    - require:
      - file: setuptools-install
pip3-install:
  file.managed:
    - name: /root/pip-19.0.3.tar.gz
    - source: salt://pycham/file/pip-19.0.3.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root && tar zxvf pip-19.0.3.tar.gz && cd pip-19.0.3 && python setup.py install && ln -sf /data/python3/bin/pip3   /usr/local/bin/pip3
    - require:
      - file: pip3-install

pycham-install:
  file.managed:
    - names: 
      - /root/pycharm-professional-2018.1.6.tar.gz:
        - source: salt://pycham/file/pycharm-professional-2018.1.6.tar.gz
      - /root/resources_en.jar:
        - source: salt://pycham/file/resources_en.jar
      - /root/Desktop/pycham.desktop:
        - source: salt://pycham/file/pycham.desktop
      - /root/Desktop/pycham-mini.txt:
        - source: salt://pycham/file/pycham-mini.txt
    - user: root
    - group: root
    - mode: 755
  cmd.run:
    - name: cd /root && tar zxvf pycharm-professional-2018.1.6.tar.gz && cp -a  pycharm-2018.1.6 /usr/local/pycham  && \cp  -af resources_en.jar  /usr/local/pycham/lib/
    - unless: test -d /usr/local/pycham
    - require:
      - file: pycham-install

host-add:
  file.append:
    - name: /etc/hosts
    - text: 0.0.0.0 account.jetbrains.com

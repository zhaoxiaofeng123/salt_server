pip-add-dir:
  file.directory:
    - name: /root/.pip
    - user: root
    - group: root
    - mode: 755
    - unless: test -d /root/.pip
pip-add-file:
  file.managed:
    - name: /root/.pip/pip.conf
    - source: salt://pycham/file/pip.conf
    - user: root
    - group: root
    - mode: 755
    - require:
      - file: pip-add-dir


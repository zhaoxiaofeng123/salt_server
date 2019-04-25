libvirt-init:
  file.managed:
    - name: /root/libvirt-python-5.1.0.tar.gz
    - source: salt://pycham/file/libvirt-python-5.1.0.tar.gz
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: yum install -y libvirt libvirt-devel && cd /root && tar zxvf  libvirt-python-5.1.0.tar.gz && cd libvirt-python-5.1.0 && python3 setup.py install
    - require: 
      - file: libvirt-init

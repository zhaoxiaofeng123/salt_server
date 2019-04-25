google-init:
  pkg.installed:
    - names:
      - libXScrnSaver
  file.managed:
    - names: 
      - /root/google-chrome-stable_current_x86_64.rpm:
        - source: salt://google/file/google-chrome-stable_current_x86_64.rpm
      - /root/Desktop/google-chrome.desktop:
        - source: salt://google/file/google-chrome.desktop
      - /root/redhat-lsb-4.1-27.el7.centos.1.x86_64.rpm:
        - source: salt://google/file/redhat-lsb-4.1-27.el7.centos.1.x86_64.rpm
    - user: root
    - group: root
    - mode: 644
  cmd.run:
    - name: cd /root && yum localinstall -y redhat-lsb-4.1-27.el7.centos.1.x86_64.rpm  google-chrome-stable_current_x86_64.rpm
    - require:
      - file: google-init

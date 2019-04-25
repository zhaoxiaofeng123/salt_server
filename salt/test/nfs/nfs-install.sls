{% set file_dir='/nfs_data'%}
{% set ipaddr='192.168.10.0/24'%}
nfs-init:
  file.directory:
    - name: {{file_dir}}
    - user: root
    - group: root
    - mode: 755
    - unless: test -d {{file_dir}}
  pkg.installed:
    - names:
      - nfs-utils
nfs-conf:
  nfs_export.present:
    - name: {{file_dir}}
    - hosts: {{ipaddr}}
    - options:
      - 'rw'
      - 'sync'
    - onlyif: test -f /etc/exports
rpcbind:
  service.running:
    - enable: True
    - reload: True
    - nfs_export: nfs-conf
nfs-server:
  service.running:
    - enable: True
    - reload: True
    - nfs_export: nfs-conf

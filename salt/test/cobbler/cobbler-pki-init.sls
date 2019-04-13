cobbler-install-init:
  pkg.installed:
    - names:
      - ed
      - perl
      - perl-Digest-SHA1
      - perl-LockFile-Simple
      - perl-libwww-perl
      - cobbler
      - cobbler-web
      - dhcp
      - tftp-server
      - pykickstart
      - httpd
      - patch

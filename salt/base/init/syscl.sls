vm.swappiness:
  sysctl.present:
    - value: 0
net.ipv4.ip_forward:
  sysctl.present:
    - value: 1
fs.file-max:
  sysctl.present:
    - value: 100000

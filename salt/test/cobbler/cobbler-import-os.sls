{% set Path='/mnt/' %}
{% set Name='centos7'%}
{% set Arch='x86_64'%}
import-os:
  
  cmd.run:
    - name: umount /dev/sr0 && mount /dev/sr0 /mnt && cobbler  import --path={{Path}}  --name={{Name}}  --arch={{Arch}}  && cobbler profile edit --name={{Name}}-{{Arch}} --kopts='net.ifnames=0 biosdevname=0'
      

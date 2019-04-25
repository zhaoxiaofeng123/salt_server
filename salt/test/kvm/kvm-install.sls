kvm-init:
  cmd.run:
    - name: echo 'this host counnot virt'
    - unless: cat /proc/cpuinfo|egrep 'svm|vmx'
add-kvm-mode:
  cmd.run:
    - name: modprobe kvm && yum install -y qemu-kvm qemu-img virt-manager libvirt libvirt-python virt-manager libvirt-client virt-install virt-viewer
    - unless: lsmod|grep kvm
    - require:
      - cmd: kvm-init
  service.running:
    - name: libvirtd
    - enable: True
    - reload: True
    - watch:
      - cmd: add-kvm-mode

cloudstack-agent:
  file.managed:
    - name: /etc/yum.repos.d/cloudstack.repo
    - source: salt://cloudstack/files/cloudstack.repo
    - user: root
    - group: root
    - mode: 644
  pkg.installed:
    - name: cloudstack-agent
    - require:
      - file: cloudstack-agent

/etc/sysconfig/libvirtd:
  file.managed:
    - source: salt://cloudstack/files/libvirtd
    - mode: 644
    - user: root
    - group: root
    
libvirtd:
  pkg.installed:
    - names:
      - libvirt
      - libvirt-python
      - libvirt-client
  file.managed:
    - name: /etc/libvirt/libvirtd.conf
    - source: salt://cloudstack/files/libvirtd.conf
    - mode: 644
    - user: root
    - group: root
    - require:
      - pkg: libvirtd
  service.running:
    - name: libvirtd
    - enable: True
    - watch:
      - file: libvirtd
      - file: /etc/sysconfig/libvirtd

avahi-daemon:
  pkg.installed:
    - name: avahi
  service.running:
    - name: avahi-daemon
    - enable: True
    - require:
      - pkg: avahi-daemon

messagebus:
  service.running:
    - name: messagebus
    - enable: True

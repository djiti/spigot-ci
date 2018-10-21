spigot-ver is distributed:
  file.managed:
    - name: /usr/local/sbin/spigot-ver
    - source: salt://spigot/spigot-ver
    - mode: 755
    - user: root
    - group: root

rotate-spigot is distributed:
  file.managed:
    - name: /usr/local/sbin/rotate-spigot
    - source: salt://spigot/rotate-spigot
    - mode: 755
    - user: root
    - group: root

spigot is running:
  service.running:
    - name: minecraft
    - watch:
      - file: build is distributed

minecraft.service is managed:
  file.managed:
    - name: /etc/systemd/system/minecraft.service
    - source: salt://spigot/minecraft.service
    - mode: 644
    - user: root
    - group: root
  module.run:
    - service.systemctl_reload:
    - onchanges:
      - file: minecraft.service is managed

spigot is rotated:
  cmd.run:
    - name: /usr/local/sbin/rotate-spigot
    - require:
      - file: rotate-spigot is distributed

build is distributed:
  file.recurse:
    - name: /misc/mine/build
    - source: salt://spigot/build
    - onchanges:
      - cmd: spigot is rotated

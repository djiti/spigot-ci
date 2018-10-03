spigot is running:
  service.running:
    - name: minecraft
    - watch:
      - cmd: spigot is rotated
    - watch:
      - file: /etc/systemd/system/minecraft.service
  file.managed:
    - name: /etc/systemd/system/minecraft.service
    - source: salt://spigot/minecraft.service
    - mode: 644
    - user: root
    - group: root

spigot is rotated:
  cmd.run:
    - name: /usr/local/sbin/rotate-spigot
    - require:
      - file: rotate-spigot is distributed
    - onchanges:
      - file: build is distributed

build is distributed:
  file.recurse:
    - name: /misc/mine/build
    - source: salt://spigot/build

rotate-spigot is distributed:
  file.managed:
    - name: /usr/local/sbin/rotate-spigot
    - source: salt://spigot/rotate-spigot
    - mode: 755
    - user: root
    - group: root


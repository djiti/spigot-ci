spigot is running:
  service.running:
    - name: java
    - watch:
      - file: /etc/systemd/system/minecraft.service
  file.managed:
    - name: /etc/systemd/system/minecraft.service
    - source: salt://spigot/minecraft.service
    - mode: 644
    - user: root
    - group: root

build is distributed:
  file.recurse:
    - name: /misc/mine/build
    - prereq:
      - cmd: spigot is rotated

rotate-spigot is distributed:
  file.managed:
    - name: /usr/local/sbin/rotate-spigot
    - source: salt://spigot/rotate-spigot
    - mode: 755
    - user: root
    - group: root

spigot is rotated:
  cmd.run:
    - /usr/local/sbin/rotate-spigot
    - require:
      - file: rotate-spigot is distributed
    - onchanges:
      - file: build is distributed

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
    - template: jinja


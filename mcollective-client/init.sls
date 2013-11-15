/etc/mcollective/client.cfg:
  file.managed:
    - source: salt://mcollective-client/client.cfg
    - user: root
    - group: root
    - mode: 400
    - template: jinja

mcollective-client:
  pkg:
    - installed

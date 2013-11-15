# I can't find these files in any RPMs, but they are there after puppet sets up mcollective...
# so copy/paste ftw!
/etc/puppet/modules/mcollective/files/plugins/actionpolicy/mcollective/util/actionpolicy.rb:
  file.managed:
    - source: salt://mcollective/actionpolicy.rb
    - user: root
    - group: root
    - mode: 400
    - template: jinja
/etc/puppet/modules/mcollective/files/plugins/actionpolicy/mcollective/util/actionpolicy.ddl:
  file.managed:
    - source: salt://mcollective/actionpolicy.ddl
    - user: root
    - group: root
    - mode: 400
    - template: jinja

/usr/local/libexec/mcollective/mcollective/util/actionpolicy.rb:
  file.managed:
    - source: salt://mcollective/actionpolicy.rb
    - user: root
    - group: root
    - mode: 400
    - template: jinja
/usr/local/libexec/mcollective/mcollective/util/actionpolicy.ddl:
  file.managed:
    - source: salt://mcollective/actionpolicy.ddl
    - user: root
    - group: root
    - mode: 400
    - template: jinja

/etc/mcollective/server.cfg:
  file.managed:
    - source: salt://mcollective/server.cfg
    - user: root
    - group: root
    - mode: 400
    - template: jinja

# only 1.8 is allowed, but I can't get yum to accept any versions...
ruby:
  pkg:
    - installed
ruby-libs:
  pkg:
    - installed
    - require:
      - pkg: ruby

mcollective:
  pkg:
    - installed
    - require:
      - pkg: ruby-libs
  service:
    - running
    - enable: True
    - require:
      - pkg: mcollective
      - file: /etc/mcollective/server.cfg
      - file: /usr/local/libexec/mcollective/mcollective/util/actionpolicy.rb
      - file: /usr/local/libexec/mcollective/mcollective/util/actionpolicy.ddl
      - file: /etc/puppet/modules/mcollective/files/plugins/actionpolicy/mcollective/util/actionpolicy.rb
      - file: /etc/puppet/modules/mcollective/files/plugins/actionpolicy/mcollective/util/actionpolicy.ddl
    - watch:
      - pkg: mcollective
      - file: /etc/mcollective/server.cfg
      - file: /usr/local/libexec/mcollective/mcollective/util/actionpolicy.rb
      - file: /usr/local/libexec/mcollective/mcollective/util/actionpolicy.ddl
      - file: /etc/puppet/modules/mcollective/files/plugins/actionpolicy/mcollective/util/actionpolicy.rb
      - file: /etc/puppet/modules/mcollective/files/plugins/actionpolicy/mcollective/util/actionpolicy.ddl

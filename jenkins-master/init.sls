include:
  - jenkins

extend:
  jenkins:
    service:
      - watch:
        - file: /var/lib/jenkins/.ssh/id_dsa
        - file: /var/lib/jenkins/config.xml
        - file: /var/lib/jenkins/credentials.xml

/var/lib/jenkins/.ssh/id_dsa:
  file.managed:
    - source: salt://jenkins/id_dsa
    - user: jenkins
    - group: nogroup
    - mode: 400
    - require:
      - pkg: jenkins
      - file: /var/lib/jenkins/.ssh

/var/lib/jenkins/config.xml:
  file.managed:
    - source: salt://jenkins-master/config.xml
    - user: jenkins
    - group: nogroup
    - mode: 400
    - template: jinja
    - require:
      - pkg: jenkins

/var/lib/jenkins/credentials.xml:
  file.managed:
    - source: salt://jenkins-master/credentials.xml
    - user: jenkins
    - group: nogroup
    - mode: 400
    - require:
      - pkg: jenkins

{% for host, hostinfo in salt['mine.get']('*', 'network.interfaces').items() %}
{{ host }}:
  ssh_known_hosts:
    - present
    - user: jenkins
    - enc: ssh-dss
{% endfor %}

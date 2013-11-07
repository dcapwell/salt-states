include:
  - openjdk

jenkins:
  pkgrepo.managed:
    - humanname: Jenkins PPA
    - name: deb http://pkg.jenkins-ci.org/debian binary/
    - comments:
      - "# Jenkins Repo"
    - key_url: http://pkg.jenkins-ci.org/debian/jenkins-ci.org.key
    - require_in:
      # must be the id, not the package name
      - pkg: jenkins
  pkg.installed:
    - require:
      - file: /var/run/jenkins
  service.running:
    - require:
      - pkg: jenkins
    - enable: True
    - watch:
      - pkg: jenkins

/var/run/jenkins:
  file.directory:
    - mode: 755

/var/lib/jenkins/.ssh:
  file.directory:
    - user: jenkins
    - group: nogroup
    - recurse:
      - user
      - group
    - require:
      - pkg: jenkins

/var/lib/jenkins/.ssh/authorized_keys:
  file.managed:
    - source: salt://jenkins/id_dsa.pub
    - user: jenkins
    - group: nogroup
    - mode: 400
    - require:
      - pkg: jenkins
      - file: /var/lib/jenkins/.ssh

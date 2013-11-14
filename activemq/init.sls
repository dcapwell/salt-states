/opt/activemq.tar.gz:
  file.managed:
    - source: http://mirror.tcpdiag.net/apache/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz
    - source_hash: md5=af195d41f1513ba174f5407bf40fec30

"/usr/bin/tar zxvf /opt/activemq.tar.gz -C /opt/apachemq":
  cmd.run:
    - stateful: True
    - cwd: /tmp
    - requires:
      - file: /opt/activemq.tar.gz

"bash /opt/activemq/bin/activemq > /tmp/activemq.log 2>&1 &;":
  cmd.run:
    - stateful: True
    - cwd: /tmp
    - requires:
      - file: /opt/activemq.tar.gz
      - cmd: "/usr/bin/tar zxvf /opt/activemq.tar.gz -C /opt/apachemq"

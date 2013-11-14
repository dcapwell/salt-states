/opt/activemq.tar.gz:
  file.managed:
    - source: http://mirror.tcpdiag.net/apache/activemq/apache-activemq/5.9.0/apache-activemq-5.9.0-bin.tar.gz
    - source_hash: md5=af195d41f1513ba174f5407bf40fec30

/opt/apachemq:
  file.directory:
    - makedirs: True
    - requires:
      - file: /opt/activemq.tar.gz

"tar zxvf /opt/activemq.tar.gz -C /opt/apachemq > /tmp/activemq-extract.log":
  cmd.run:
    - stateful: True
    - cwd: /tmp
    - requires:
      - file: /opt/apachemq

"bash -c './bin/activemq start > /tmp/activemq.log 2>&1 &'":
  cmd.run:
    - stateful: True
    - cwd: /opt/apachemq/apache-activemq-5.9.0
    - requires:
      - file: /opt/activemq.tar.gz
      - cmd: "/usr/bin/tar zxvf /opt/activemq.tar.gz -C /opt/apachemq"

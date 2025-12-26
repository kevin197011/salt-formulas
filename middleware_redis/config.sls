# Redis Configuration

redis_config:
  file.managed:
    - name: /etc/redis/redis.conf
    - source: salt://redis/files/redis.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: redis_packages

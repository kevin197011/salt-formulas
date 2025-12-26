# Redis Service

redis_service:
  service.running:
    - name: redis
    - enable: True
    - require:
      - file: redis_config

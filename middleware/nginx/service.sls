# Nginx Service

nginx_service:
  service.running:
    - name: nginx
    - enable: True
    - reload: True
    - require:
      - file: nginx_config
    - watch:
      - file: nginx_config

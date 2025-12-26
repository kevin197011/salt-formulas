# MySQL 服务管理

{% from "middleware_mysql/map.jinja" import mysql with context %}

mysql_service:
  service.running:
    - name: {{ mysql.service }}
    - enable: True
    - require:
      - pkg: mysql_server_package
      - file: mysql_config_file

# MySQL 配置

{% from "middleware_mysql/map.jinja" import mysql, settings with context %}

mysql_config_file:
  file.managed:
    - name: {{ mysql.config_file }}
    - source: salt://middleware_mysql/files/my.cnf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - context:
        mysql: {{ mysql | json }}
        settings: {{ settings | json }}
    - require:
      - pkg: mysql_server_package
    - watch_in:
      - service: mysql_service

mysql_log_dir:
  file.directory:
    - name: /var/log/mysql
    - user: {{ mysql.user }}
    - group: {{ mysql.group }}
    - mode: 755
    - makedirs: True

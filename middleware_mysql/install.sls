# MySQL 安装

{% from "middleware_mysql/map.jinja" import mysql, settings with context %}

mysql_server_package:
  pkg.installed:
    - name: {{ mysql.server_pkg }}

mysql_client_package:
  pkg.installed:
    - name: {{ mysql.client_pkg }}

mysql_data_dir:
  file.directory:
    - name: {{ mysql.data_dir }}
    - user: {{ mysql.user }}
    - group: {{ mysql.group }}
    - mode: 750
    - makedirs: True
    - require:
      - pkg: mysql_server_package

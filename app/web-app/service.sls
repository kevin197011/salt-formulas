# Web Application Service

{% set app_name = pillar.get('web_app.name', 'myapp') %}
{% set app_root = pillar.get('web_app.root', '/opt/' + app_name) %}
{% set app_user = pillar.get('web_app.user', app_name) %}

# Create systemd service file
app_service_file:
  file.managed:
    - name: /etc/systemd/system/{{ app_name }}.service
    - source: salt://web-app/files/app.service.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644

# Reload systemd daemon
systemd_reload:
  cmd.run:
    - name: systemctl daemon-reload
    - onchanges:
      - file: app_service_file

# Enable and start service
app_service:
  service.running:
    - name: {{ app_name }}
    - enable: True
    - require:
      - file: app_service_file
    - watch:
      - file: app_service_file

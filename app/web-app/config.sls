# Web Application Configuration

{% set app_name = pillar.get('web_app.name', 'myapp') %}
{% set app_root = pillar.get('web_app.root', '/opt/' + app_name) %}
{% set app_port = pillar.get('web_app.port', 3000) %}

# Application configuration file
app_config:
  file.managed:
    - name: {{ app_root }}/config.json
    - source: salt://web-app/files/config.json.j2
    - template: jinja
    - user: {{ pillar.get('web_app.user', app_name) }}
    - group: {{ pillar.get('web_app.group', app_name) }}
    - mode: 644

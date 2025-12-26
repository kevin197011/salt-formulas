# Web Application Deployment

{% set app_name = pillar.get('web_app.name', 'myapp') %}
{% set app_root = pillar.get('web_app.root', '/opt/' + app_name) %}
{% set app_user = pillar.get('web_app.user', app_name) %}
{% set app_group = pillar.get('web_app.group', app_name) %}

# Create application user
{{ app_user }}:
  user.present:
    - name: {{ app_user }}
    - home: {{ app_root }}
    - shell: /bin/bash
    - system: True
    - createhome: True

# Create application directory
app_directory:
  file.directory:
    - name: {{ app_root }}
    - user: {{ app_user }}
    - group: {{ app_group }}
    - mode: 755
    - require:
      - user: {{ app_user }}

# Deploy application files
app_files:
  file.recurse:
    - name: {{ app_root }}/app
    - source: salt://web-app/files/app
    - user: {{ app_user }}
    - group: {{ app_group }}
    - dir_mode: 755
    - file_mode: 644
    - require:
      - file: app_directory

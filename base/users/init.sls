# Users Formula
# 管理系统用户

{% for user_name, user_config in pillar.get('users', {}).items() %}

{{ user_name }}:
  user.present:
    - name: {{ user_name }}
    - uid: {{ user_config.get('uid') }}
    - gid: {{ user_config.get('gid') }}
    - home: {{ user_config.get('home', '/home/' + user_name) }}
    - shell: {{ user_config.get('shell', '/bin/bash') }}
    - groups: {{ user_config.get('groups', []) }}
    {% if user_config.get('password') %}
    - password: {{ user_config.password }}
    {% endif %}
    {% if user_config.get('enforce_password', True) %}
    - enforce_password: {{ user_config.enforce_password }}
    {% endif %}

{% endfor %}

# MOTD (Message of the Day) Formula
# 简单的测试 Formula，用于验证参数传递

{% set config = salt['pillar.get']('motd', {}) %}
{% set message = config.get('message', 'Welcome to this server!') %}
{% set show_hostname = config.get('show_hostname', true) %}
{% set show_date = config.get('show_date', true) %}
{% set admin_email = config.get('admin_email', 'admin@example.com') %}

motd_file:
  file.managed:
    - name: /etc/motd
    - contents: |
        ========================================
        {{ message }}
        ========================================
        {% if show_hostname %}
        Hostname: {{ grains['id'] }}
        {% endif %}
        {% if show_date %}
        Last updated: {{ salt['cmd.run']('date') }}
        {% endif %}
        Admin contact: {{ admin_email }}
        ========================================
    - user: root
    - group: root
    - mode: 644

motd_test_result:
  cmd.run:
    - name: echo "MOTD configured with message='{{ message }}'"
    - require:
      - file: motd_file

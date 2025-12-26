# Sysctl Formula
# 配置内核参数

{% for param_name, param_value in pillar.get('sysctl', {}).items() %}

sysctl_{{ param_name|replace('.', '_') }}:
  sysctl.present:
    - name: {{ param_name }}
    - value: {{ param_value }}

{% endfor %}

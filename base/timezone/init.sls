# Timezone Formula
# 设置系统时区

timezone:
  timezone.system:
    - name: {{ pillar.get('timezone', 'Asia/Shanghai') }}
    - utc: {{ pillar.get('timezone.utc', True) }}

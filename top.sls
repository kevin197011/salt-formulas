# Top file for Salt Formulas
# 定义Formula的执行顺序和目标主机

base:
  '*':
    - base_timezone
    - base_users
    - base_sysctl

middleware:
  'G@roles:web or G@roles:app':
    - middleware_nginx
  'G@roles:cache or G@roles:db':
    - middleware_redis

runtime:
  'G@roles:java':
    - runtime_java
  'G@roles:nodejs or G@roles:web':
    - runtime_nodejs

app:
  'G@roles:web':
    - app_web_app

# Top file for Salt Formulas
# 定义Formula的执行顺序和目标主机

base:
  '*':
    - base.timezone
    - base.users
    - base.sysctl

middleware:
  'G@roles:web or G@roles:app':
    - middleware.nginx
  'G@roles:cache or G@roles:db':
    - middleware.redis

runtime:
  'G@roles:java':
    - runtime.java
  'G@roles:nodejs or G@roles:web':
    - runtime.nodejs

app:
  'G@roles:web':
    - app.web-app

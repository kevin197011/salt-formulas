# Nginx Configuration

nginx_config:
  file.managed:
    - name: /etc/nginx/nginx.conf
    - source: salt://nginx/files/nginx.conf.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 644
    - require:
      - pkg: nginx_packages

nginx_sites_available:
  file.directory:
    - name: /etc/nginx/sites-available
    - user: root
    - group: root
    - mode: 755

nginx_sites_enabled:
  file.directory:
    - name: /etc/nginx/sites-enabled
    - user: root
    - group: root
    - mode: 755

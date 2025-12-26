# Node.js Environment Configuration

nodejs_path_env:
  environ.setenv:
    - name: PATH
    - value: $PATH:/usr/bin:/usr/local/bin
    - update_minion: True

# Configure npm
npm_config:
  file.managed:
    - name: /root/.npmrc
    - source: salt://nodejs/files/npmrc.j2
    - template: jinja
    - user: root
    - group: root
    - mode: 600

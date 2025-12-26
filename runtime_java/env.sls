# Java Environment Configuration

java_home_env:
  environ.setenv:
    - name: JAVA_HOME
    - value: /usr/lib/jvm/default
    - update_minion: True

java_path_env:
  environ.setenv:
    - name: PATH
    - value: $PATH:$JAVA_HOME/bin
    - update_minion: True

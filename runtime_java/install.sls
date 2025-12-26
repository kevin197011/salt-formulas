# Java Installation

{% set java_version = pillar.get('java.version', 'openjdk17') %}

java_packages:
  pkg.installed:
    - names:
      - {{ java_version }}

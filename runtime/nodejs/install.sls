# Node.js Installation

{% set nodejs_version = pillar.get('nodejs.version', 'nodejs') %}
{% set npm_version = pillar.get('nodejs.npm_version', 'npm') %}

nodejs_packages:
  pkg.installed:
    - names:
      - {{ nodejs_version }}
      - {{ npm_version }}

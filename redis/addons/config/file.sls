# -*- coding: utf-8 -*-
# vim: ft=sls

{%- set tplroot = tpldir.split('/')[0] %}
{%- from tplroot ~ "/map.jinja" import redis with context %}

# Include for requisites.
include:
  - redis.server
  - .module


# Make sure the log directory exists.
redis-log_dir-file-directory-addons-redis:
  file.directory:
    - name: /var/log/redis
    - user: redis
    - group: redis
    - file_mode: 660
    - recurse:
      - user
      - group
      - mode
    - require_in:
      - sls: redis.server


# Make sure the PID directory exists.
redis-pid_dir-file-directory-addons-redis:
  file.directory:
    - name: /var/run/redis
    - user: redis
    - group: redis
    - file_mode: 660
    - recurse:
      - user
      - group
      - mode
    - require_in:
      - sls: redis.server


# Tell systemd that redis will be operating in supervised systemd mode.
{% if redis.supervised == 'systemd' %}
redis-redis_service-file-keyvalue-addons-redis:
  file.keyvalue:
    - name: /etc/systemd/system/redis.service
    - key: Type
    - value: notify
    - separator: '='
    - require_in:
      - service: redis_service
    - watch_in:
      - module: redis-systemctl_deamon_reload-module-wait-addons-redis
{% endif %}

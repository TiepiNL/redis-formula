{% from "redis/map.jinja" import redis_settings with context %}

# Deal with the warning message:
# WARNING: The TCP backlog setting of <tcp-backlog> cannot be enforced because /proc/sys/net/core/somaxconn is set to the lower value of <tcp-backlog>.
# Set somaxconn in pillar config to a higher value than <tcp-backlog> (default 511).
redis-sysctl_d_redis_conf-redis-sysctl-file-managed:
  file.managed:
    - name: /etc/sysctl.d/redis.conf
    - contents: |
        net.core.somaxconn={{ redis_settings.get('somaxconn', '128') }}

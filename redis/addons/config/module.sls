# -*- coding: utf-8 -*-
# vim: ft=sls

# The following state is inert by default and can be used by other states to
# trigger a deamon reload as needed.
redis-systemctl_deamon_reload-module-wait-addons-redis:
  module.wait:
    - name: cmd.run
    - cmd: 'systemctl deamon-reload'
    - python_shell: True


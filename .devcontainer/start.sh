#!/bin/bash
/usr/sbin/sshd
exec /usr/bin/tini -s /run/entry.sh

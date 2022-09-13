#!/bin/sh
trap 'exit 0' SIGTERM
source /build-config.sh


/usr/sbin/crond -l 8

echo "Running Adanet Logger"
exec /usr/sbin/rsyslogd -n

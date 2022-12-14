# rsyslog syslog appliance container configuration.
# This file will be sourced upon container startup.
# Uncomment those settings that you need and set them to your
# desired values.

# general container app settings:
export TZ=UTC
#export CONTAINER_SILENT=on  # do not emit startup message
export ENABLE_STATISTICS=on

# Do we write log files?
export ENABLE_LOGFILES=on # yes, we do (comment out to disable)
# Where do we write to?
# path for host-specific files is: /logs/hosts/HOSTNAME
export LOGFILES_STORE="/logs/hosts/%hostname:::secpath-replace%/messages.log"
# you can of course overwrite this. For example, the below definition
# uses the program name instead of a fixed name "messages.log". That means
# for each host, a separate file for each program will be generated.
#export LOGFILES_STORE="/logs/hosts/%hostname:::secpath-replace%/%programname:::secpath-replace%.log"

# If you have an account with Logsene, enter your access
# information below:
#export LOGSENE_TOKEN=
#export LOGSENE_URL=logsene-receiver.eu.sematext.com

# Settings for debugging the container
#export USE_VALGRIND=on
#export RSYSLOG_DEBUG="debug nostdout"
#export RSYSLOG_DEBUGLOG="/logs/rsyslog-internal-debug.log"

cat > /etc/rsyslog.conf.d/${LOG_NAME}.conf << EOF
if \$fromhost-ip startswith '172.17.0.1' then /var/log/adatanet/${LOG_NAME}.log
& stop
EOF


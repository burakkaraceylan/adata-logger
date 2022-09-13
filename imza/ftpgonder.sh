#!/bin/sh

HOST=$FTP_HOST
USER=$FTP_USER
PASSWD=$FTP_PASSWD
LOCALPATH='/imza/imzali'
DIR=$FTP_DIR

if nc -z $FTP_HOST 21 2>/dev/null; then
    echo "$FTP_HOST ✓"
else
    echo "$FTP_HOST ✗"
    exit 1
fi


lftp <<EOF
open -u $FTP_USER,$FTP_PASSWD ftp://$FTP_HOST
cd $FTP_DIR
lcd $LOCALPATH
mput *
quit
exit;
EOF

rm -f $LOCALPATH/*

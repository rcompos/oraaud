#!/bin/bash

export MARKER_LIST=`/bin/find /opt/oracle/admin/*/adump -name \"*aud\" -mtime +2`

if [[ $MARKER_LIST ]]; then 
  /bin/echo $MARKER_LIST | /usr/bin/xargs /bin/rm
fi

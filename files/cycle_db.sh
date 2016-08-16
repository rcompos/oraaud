#!/bin/bash

set -x
for DB_NAME in $(/tmp/usfs_local_sids | sed 's/[0-9]$//'); do
  export DB_NAME
  echo srvctl stop database -d $DB_NAME -o immediate
  srvctl stop database -d $DB_NAME -o immediate
  echo srvctl start database -d $DB_NAME
  srvctl start database -d $DB_NAME
done 2>&1 | tee -a /home/oracle/system/audit/.audit/install_ora_audit.sh

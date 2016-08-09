#!/bin/bash

for DB_NAME in $(/home/oracle/system/usfs_local_sids | sed \'s/[0-9]$//\'); do export DB_NAME; echo srvctl stop database -d $DB_NAME -o immediate; srvctl stop database -d $DB_NAME -o immediate; echo srvctl start database -d $DB_NAME; srvctl start database -d $D  B_NAME; done

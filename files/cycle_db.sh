#!/bin/bash

touch /home/oracle/system/audit/.audit/install_ora_audit.sh || exit 1

LOG=/home/oracle/system/audit/.audit/install_ora_audit.sh
{
   set -x
   . /home/oracle/.bash_profile

   for ORACLE_SID in $(/fslink/sysinfra/oracle/common/db/usfs_local_sids); do
      set -x
      export ORACLE_SID;
      echo "ORACLE_SID=$ORACLE_SID";
      echo "shutdown immediate" | sqlplus -s / as sysdba;
      echo "shutdown abort" | sqlplus -s / as sysdba;
      echo "Startup:";
      echo "startup" | sqlplus -s / as sysdba;
      echo
   done
} 2>&1 | tee -a /home/oracle/system/audit/.audit/install_ora_audit.sh


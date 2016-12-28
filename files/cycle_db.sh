#!/usr/bin/env ksh
touch /home/oracle/system/audit/.audit/install_ora_audit.sh || exit 1
export LOG=/home/oracle/system/audit/.audit/install_ora_audit.sh

{
   alias shopt=': '; UID=$(id | sed 's|(.*||;s|.*=||'); . /home/oracle/.bash_profile
   for ORACLE_SID in $(/fslink/sysinfra/oracle/common/db/usfs_local_sids); do
      export ORACLE_SID;
      echo "$(date): ORACLE_SID=$ORACLE_SID";
      echo "shutdown immediate" | sqlplus -s / as sysdba;
      echo "shutdown abort" | sqlplus -s / as sysdba;
      echo "Startup:";
      echo "startup" | sqlplus -s / as sysdba;
      echo
      echo "========================================================================"
   done
} 2>&1 | tee -a /home/oracle/system/audit/.audit/install_ora_audit.sh

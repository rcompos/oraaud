#!/usr/bin/env ksh

export Script_name=$(basename $0)
touch /home/oracle/system/audit/.audit/install_ora_audit.sh || exit 1
export LOG=/home/oracle/system/audit/.audit/install_ora_audit.sh.log

{
   function ECHO {
      echo -e "$(date "+%Y-%m-%d:%H:%M:%S")-$Script_name: \c" >> $LOG
      echo "$*"
   }

   alias shopt=': '; UID=$(id | sed 's|(.*||;s|.*=||'); . /home/oracle/.bash_profile
   for ORACLE_SID in $(/fslink/sysinfra/oracle/common/db/usfs_local_sids); do
      ECHO "$(date) ========================================================================"
      export ORACLE_SID;
      ECHO "ORACLE_SID=$ORACLE_SID";
      ECHO "shutdown immediate" | sqlplus -s / as sysdba;
      ECHO "shutdown abort" | sqlplus -s / as sysdba;
      ECHO "Startup:";
      ECHO "startup" | sqlplus -s / as sysdba;
      ECHO
   done
} 2>&1 | tee -a $LOG

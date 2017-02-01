#!/usr/bin/env ksh

export Script_name=$(basename $0)
touch /home/oracle/system/audit/.audit/install_ora_audit.sh || exit 1
export LOG=/home/oracle/system/audit/.audit/install_ora_audit.sh.log
export LOG_2=/var/tmp/cycle_db.sh.log

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
      rm -f $LOG_2.$ORACLE_SID
      if [[ -f $LOG_2.$ORACLE_SID ]]; then
         ECHO "ERROR: Can't remove $LOG_2.$ORACLE_SID"
         exit 1
      fi

      ECHO show parameter audit_trail | sqlplus -s / as sysdba 2>&1 | tee $LOG_2.$ORACLE_SID;
      if ! grep ^audit_trail.*string.*NONE $LOG_2.$ORACLE_SID; then
         ECHO ".. Didn't find 'audit_trail NONE', therefore not restarting the database"
         ECHO
         continue
      fi
      ECHO ".. Found 'audit_trail NONE', restarting the database now"
      ECHO "shutdown immediate" | sqlplus -s / as sysdba;
      ECHO "shutdown abort" | sqlplus -s / as sysdba;
      ECHO "Startup:";
      ECHO "startup" | sqlplus -s / as sysdba;
      ECHO
   done
} 2>&1 | tee -a $LOG


class oraaud::service {

  exec {'service_config':
    command => '/home/oracle/system/audit/config_oraaud_OS_service.sh',
    path    => '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
    #refreshonly => true,
    notify  => Exec['cycle_db'],
  }

  exec {'cycle_db':
    command     => "${::oraaud::dir_audit}/${::oraaud::script_cycle_db}",
    path        => "${::oraaud::path_default}:${::oraaud::dir_audit}",
    refreshonly => false,
    user        => $::oraaud::db_user,
    # Only execute cycle_db.sh if the RPM was applied within the last 10 minutes.
    onlyif      => 'ksh " {
         set -x;
         echo == BEGIN Puppet install class, cycle_db exec ==;
         id;
         rm -f /var/tmp/fs615_oraaud.log
         RPM_APPLIED_DATE=\$(rpm -q --last rn-ora_audit_nitc | sed \"s/rn-ora_audit_nitc[^ ]* *//\" ); 
         if [[ -n \$RPM_APPLIED_DATE ]]; then
            echo RPM_APPLIED_DATE=\$RPM_APPLIED_DATE
            RPM_APPLIED_EPOCH=\$(date --date=\"\$RPM_APPLIED_DATE\" +%s)
            NOW_EPOC=\$(date +%s)
            seconds_since_rpm_applied=\$((NOW_EPOC-RPM_APPLIED_EPOCH))
            echo -e seconds_since_rpm_applied=\\c
            echo \$seconds_since_rpm_applied | tee /var/tmp/fs615_oraaud.log
            echo == END Puppet install class, cycle_db exec ==;
         fi
      } 2>&1 | tee -a /home/oracle/system/audit/.audit/install_ora_audit.sh.log
      seconds_since_rpm_applied=\$(cat /var/tmp/fs615_oraaud.log)
      echo outside_seconds_since_rpm_applied=\$seconds_since_rpm_applied >> /home/oracle/system/audit/.audit/install_ora_audit.sh.log
      ((10<seconds_since_rpm_applied && seconds_since_rpm_applied<600))" ',
    notify      => Exec['marker_rm'],
    #subscribe   => File["$dir_audit/$script_cycle_db"],
  }

  exec {'marker_rm':
    #command     => '/bin/find /opt/oracle/admin/*/adump -name "*aud" -mtime +2 | xargs rm',
    command     => "${::oraaud::dir_audit}/${::oraaud::script_marker_rm}",
    path        => "${::oraaud::path_default}:${::oraaud::dir_audit}",
    refreshonly => true,
    user        => $::oraaud::db_user,
    notify      => Exec['marker_touch'],
  }

  exec {'marker_touch':
    command     => "/bin/touch ${::oraaud::dir_audit}/.audit_marker_late.txt ${::oraaud::dir_audit}/.audit_marker_newer_pending.txt ${::oraaud::dir_audit}/.audit_marker_newer.txt",
    path        => $::oraaud::path_default,
    refreshonly => true,
    user        => $::oraaud::db_user,
  }
}

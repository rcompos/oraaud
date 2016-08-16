class oraaud::service (
) inherits oraaud {

  exec {'service_config':
    command     => "/home/oracle/system/audit/config_oraaud_OS_service.sh",
    path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
    #refreshonly => true,
    notify      => Exec['cycle_db'],
  }

  exec {'cycle_db':
    #command     => "/bin/sh -c for DB_NAME in $(/home/oracle/system/usfs_local_sids | sed \'s/[0-9]$//\'); do export DB_NAME; echo srvctl stop database -d $DB_NAME -o immediate; srvctl stop database -d $DB_NAME -o immediate; echo srvctl start database -d $DB_NAME; srvctl start database -d $DB_NAME; done",
    command     => "$dir_audit/$script_cycle_db",
    path        => "$path_default:$dir_audit",
    refreshonly => false,
    user        => "$db_user",
    notify      => Exec['marker_rm'],
    #subscribe   => File["$dir_audit/$script_cycle_db"],
  }

  exec {'marker_rm':
    #command     => '/bin/find /opt/oracle/admin/*/adump -name "*aud" -mtime +2 | xargs rm',
    command     => "$dir_audit/$script_marker_rm",
    path        => "$path_default:$dir_audit",
    refreshonly => true,
    user        => "$db_user",
    notify      => Exec['marker_touch'],
    }

  exec {'marker_touch':
    command     => "/bin/touch $dir_audit/.audit_marker_late.txt $dir_audit/.audit_marker_newer_pending.txt $dir_audit/.audit_marker_newer.txt",
    path        => "$path_default",
    refreshonly => true,
    user        => "$db_user",
  }


}

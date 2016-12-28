
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

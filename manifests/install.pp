class oraaud::install (
) inherits oraaud {

  case $::osfamily {

    'RedHat': {
      if $::operatingsystemmajrelease + 0 > 7 {
        fail("Class['oraaud::install']: Unsupported operating system majrelease ${::operatingsystemmajrelease}")
      }
    }

    default: {
         fail("Class['oraaud::install']: Unsupported osfamily: ${::osfamily}")
    }

  }

  package { '$expect_package':
    ensure => $expect_ensure,
    name   => $expect_package,
  }

  staging::deploy { '$file_tar':
    source => '$dir_src/$file_tar',
    target => '/',
    notify => [
      File['$dir_audit/$script_audit'],
      Exec['compare_audit'],
    ],
    unless => 'ls $dir_audit/.audit_marker_late.txt',
  }

  file {'$dir_audit/$script_audit':
    mode   => '0755',
    before => Exec['install_audit'],
  }

  file {'$dir_audit/$script_compare':
    mode   => '0755',
    before => Exec['compare_audit'],
  }

  exec {'compare_audit': 
    command      => '$script_compare',
    path        => '$path_default:$dir_audit',
    refreshonly => true,
    notify      => Exec['install_audit'],
  }

  exec {'install_audit':
    command     => '$script_audit',
    path        => '$path_default:$dir_audit',
    refreshonly => true,
    notify      => Exec['cycledb'],
  }

  exec {'cycledb':
    command     => 'sh -c for DB_NAME in $(/home/oracle/system/usfs_local_sids | sed \'s/[0-9]$//\'); do export DB_NAME; echo srvctl stop database -d $DB_NAME -o immediate; srvctl stop database -d $DB_NAME -o immediate; echo srvctl start database -d $DB_NAME; srvctl start database -d $DB_NAME; done',
    path        => '$path_default',
    refreshonly => true,
    user        => $db_user,
    notify      => Exec['marker_rm'],
  }

  exec {'marker_rm':
    command     => 'find /opt/oracle/admin/*/adump -name "*aud" -mtime +2 | xargs rm',
    path        => '$path_default',
    refreshonly => true,
    user        => $db_user,
    notify      => Exec['marker_touch'],
  }

  exec {'marker_touch':
    command     => 'touch $dir_audit/.audit_marker_late.txt /home/oracle/system/audit/.audit_marker_newer_pending.txt /home/oracle/system/audit/.audit_marker_newer.txt',
    path        => '$path_default',
    refreshonly => true,
    user        => $db_user,
    notify      => Exec['service_config'],
  }

  exec {'service_config':
    command     => '$dir_audit/config_oraaud_OS_service.sh',
    path        => '$path_default',
    refreshonly => true,
  }

}

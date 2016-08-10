class oraaud::install (
) inherits oraaud {

  #   case $::osfamily {
  #   'RedHat': {
  #      if $::operatingsystemmajrelease + 0 >= 8 {
  #        fail("Class['oraaud::install']: Unsupported operating system majrelease ${::operatingsystemmajrelease}")
  #      }
  #    }
  #    default: {
  #       fail("Class['oraaud::install']: Unsupported osfamily: ${::osfamily}")
  #     }
  # }

   package { "$expect_package":
     ensure => "$expect_ensure",
     name   => "$expect_package",
   }

  staging::deploy { "$file_tar":
    source => "$dir_src/$file_tar",
    target => "/",
    notify => [
      File["$dir_audit/$script_audit"],
      Exec['compare_audit'],
    ],
    unless => "ls $dir_audit/.audit_marker_late.txt",
  }

  file { "$dir_audit/$script_cycle_db":
    ensure => file,
    source => "puppet:///modules/oraaud/$script_cycle_db",
    mode   => 'ug+x',
    owner  => "$db_user",
    group  => "$db_group",
    before => Exec['cycle_db'],
  }

  file { "$dir_audit/$script_marker_rm":
    ensure => file,
    source => "puppet:///modules/oraaud/$script_marker_rm",
    mode   => 'ug+x',
    owner  => "$db_user",
    group  => "$db_group",
    before => Exec['marker_rm'],
  }

  file {"$dir_audit/$script_audit":
    mode   => "0755",
    before => Exec['install_audit'],
  }

  file {"$dir_audit/$script_compare":
    mode   => '0755',
    before => Exec['compare_audit'],
  }

  exec {'compare_audit': 
    command      => "$dir_audit/$script_compare",
    #path        => "/home/oracle/system/audit",
    #path        => "$dir_audit",
    path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$dir_audit",
    refreshonly => true,
    notify      => Exec['install_audit'],
  }

  exec {'install_audit':
    command     => "$dir_audit/$script_audit",
    #path        => "/home/oracle/system/audit",
    path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$dir_audit",
    refreshonly => true,
    notify      => Exec['cycle_db'],
  }

  exec {'cycle_db':
    #command     => "/bin/sh -c for DB_NAME in $(/home/oracle/system/usfs_local_sids | sed \'s/[0-9]$//\'); do export DB_NAME; echo srvctl stop database -d $DB_NAME -o immediate; srvctl stop database -d $DB_NAME -o immediate; echo srvctl start database -d $DB_NAME; srvctl start database -d $DB_NAME; done",
    command     => "$dir_audit/$script_cycle_db",
    path        => "$path_default:$dir_audit",
    refreshonly => true,
    user        => "$db_user",
    notify      => Exec['marker_rm'],
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
    notify      => Exec['service_config'],
  }

  exec {'service_config':
    command     => "/home/oracle/system/audit/config_oraaud_OS_service.sh",
    path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
    refreshonly => true,
  }

}

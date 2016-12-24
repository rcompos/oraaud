class oraaud::prereq {

  package { $::oraaud::expect_package:
    ensure => $::oraaud::expect_ensure,
    name   => $::oraaud::expect_package,
  }

  #notify{"This is notice.":}
  #notify{"This is notice 2.":}
  #staging::deploy { $::oraaud::file_tar:
  #  source => "${::oraaud::dir_src}/${::oraaud::file_tar}",
  #  target => '/',
  #  notify => [
  #    File["${::oraaud::dir_audit}/${::oraaud::script_audit}"],
  #    #Exec['compare_audit'],
  #  ],
  #  #unless => "ls $dir_audit/.audit_marker_late.txt",
  #}

  #TODO notify{"This is a notice: command     => 'tar -pxvf ${::oraaud::dir_src}/${::oraaud::file_tar}', ":}
  exec { 'fs615_untar':
    #TODO OLD  command     => '/bin/tar -pxvf /opt/staging/oraaud/rn-ora_audit_nitc.tar',
    #TODO OLD command     => '/bin/tar -pxvf /fslink/sysinfra/oracle/scripts/misc/auditing/install_ora_audit.sh',
    command     => '/bin/tar -pxvf ${::oraaud::dir_src}/${::oraaud::file_tar}',
    cwd         => '/',
    user        => 'root',
    #OLD require     => File["/home/oracle/system/audit/"],
    creates     => File["/home/oracle/system/audit/"],
    refreshonly => true,
  }

  # END JIM

  file { "${::oraaud::dir_audit}/${::oraaud::script_cycle_db}":
    ensure => file,
    source => "puppet:///modules/oraaud/${::oraaud::script_cycle_db}",
    mode   => 'ug+x',
    owner  => $::oraaud::db_user,
    group  => $::oraaud::db_group,
    require => Exec['fs615_untar'],   #TODO, new
    #before => Exec['cycle_db'],
  }

  file { "${::oraaud::dir_audit}/${::oraaud::script_marker_rm}":
    ensure => file,
    source => "puppet:///modules/oraaud/${::oraaud::script_marker_rm}",
    mode   => 'ug+x',
    owner  => $::oraaud::db_user,
    group  => $::oraaud::db_group,
    #before => Exec['marker_rm'],
  }

  file {$::oraaud::dir_audit:
    mode   => '0755',
    before => File["${::oraaud::dir_audit}/${::oraaud::script_audit}"],
  }

# JTM
# file {"${::oraaud::dir_audit}/${::oraaud::script_audit}":
#   mode   => '0755',
#   #before => Exec['install_audit'],
# }


  #file {"$dir_audit/$script_compare":
  #  mode   => '0755',
  #  before => Exec['compare_audit'],
  #}

}

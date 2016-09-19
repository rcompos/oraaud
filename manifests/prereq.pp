class ::oraaud::prereq {

  package { $::oraaud::expect_package:
    ensure => $::oraaud::expect_ensure,
    name   => $::oraaud::expect_package,
  }

  #notify{"This is notice.":}
  staging::deploy { $::oraaud::file_tar:
    source => "${::oraaud::dir_src}/${::oraaud::file_tar}",
    target => '/',
    notify => [
      File["${::oraaud::dir_audit}/${::oraaud::script_audit}"],
      #Exec['compare_audit'],
    ],
    #unless => "ls $dir_audit/.audit_marker_late.txt",
  }

  file { "${::oraaud::dir_audit}/${::oraaud::script_cycle_db}":
    ensure => file,
    source => "puppet:///modules/oraaud/${::oraaud::script_cycle_db}",
    mode   => 'ug+x',
    owner  => $::oraaud::db_user,
    group  => $::oraaud::db_group,
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

  file {"${::oraaud::dir_audit}/${::oraaud::script_audit}":
    mode   => '0755',
    #before => Exec['install_audit'],
  }


  #file {"$dir_audit/$script_compare":
  #  mode   => '0755',
  #  before => Exec['compare_audit'],
  #}

}

class oraaud::prereq {

  package { $::oraaud::expect_package:
    ensure => $::oraaud::expect_ensure,
    name   => $::oraaud::expect_package,
  }

  package{ "${::oraaud::file_rpm_noext}":
     provider => 'rpm',
     ensure   => 'present',
     source   => "${::oraaud::dir_src}/${::oraaud::file_rpm}",
  }

  file { "${::oraaud::dir_audit}/${::oraaud::script_marker_rm}":
    ensure => file,
    source => "puppet:///modules/oraaud/${::oraaud::script_marker_rm}",
    mode   => 'ug+x',
    owner  => $::oraaud::db_user,
    group  => $::oraaud::db_group,
    #before => Exec['marker_rm'],
  }

  file { [ "$::oraaud::dir_audit", "$::oraaud::dir_audit/.audit" ] :
    ensure => 'directory',
    owner  => 'oracle',
    group  => 'oinstall',
    mode   => '0755',
    before => File["${::oraaud::dir_audit}/${::oraaud::script_audit}"],
  }

  file {"${::oraaud::dir_audit}/${::oraaud::script_audit}":
    mode   => '0755',
    before =>  Exec['cycle_db'],
    require => Package["${::oraaud::file_rpm_noext}"],
  } 

  file { "${::oraaud::dir_audit}/${::oraaud::script_cycle_db}":
    ensure => file,
    source => "puppet:///modules/oraaud/${::oraaud::script_cycle_db}",
    mode   => 'ug+x',
    owner  => $::oraaud::db_user,
    group  => $::oraaud::db_group,
    require => Package["${::oraaud::file_rpm_noext}"],   #TODO, new
    #before => Exec['cycle_db'],
  }

  #file {"$dir_audit/$script_compare":
  #  mode   => '0755',
  #  before => Exec['compare_audit'],
  #}

}

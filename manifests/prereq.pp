class oraaud::prereq (
) inherits oraaud {

   package { "$expect_package":
     ensure => "$expect_ensure",
     name   => "$expect_package",
   }

  notice("This is a notice.")
  staging::deploy { "$file_tar":
    source => "$dir_src/$file_tar",
    target => "/",
    notify => [
      File["$dir_audit/$script_audit"],
      #Exec['compare_audit'],
    ],
    #unless => "ls $dir_audit/.audit_marker_late.txt",
  }

  file { "$dir_audit/$script_cycle_db":
    ensure => file,
    source => "puppet:///modules/oraaud/$script_cycle_db",
    mode   => 'ug+x',
    owner  => "$db_user",
    group  => "$db_group",
    #before => Exec['cycle_db'],
  }

  file { "$dir_audit/$script_marker_rm":
    ensure => file,
    source => "puppet:///modules/oraaud/$script_marker_rm",
    mode   => 'ug+x',
    owner  => "$db_user",
    group  => "$db_group",
    #before => Exec['marker_rm'],
  }

  file {"$dir_audit/$script_audit":
    mode   => "0755",
    #before => Exec['install_audit'],
  }

  #file {"$dir_audit/$script_compare":
  #  mode   => '0755',
  #  before => Exec['compare_audit'],
  #}

}

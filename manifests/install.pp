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

  #exec {'compare_audit': 
  #  command      => "$dir_audit/$script_compare",
  #  #path        => "/home/oracle/system/audit",
  #  #path        => "$dir_audit",
  #  path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$dir_audit",
  #  refreshonly => true,
  #  notify      => Exec['install_audit'],
  #}

  notify { "\$scp_pw: $scp_pw": }
  exec {'install_audit':
    command     => "$dir_audit/$script_audit",
    #path        => "/home/oracle/system/audit",
    path        => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$dir_audit",
    user        => "$db_user",
    #refreshonly => true,
    environment => ["SCP_PW=$scp_pw"],
  }

}

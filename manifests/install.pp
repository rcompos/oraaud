class oraaud::install (
) inherits oraaud {

   case $::osfamily {
     'RedHat': {
        if $::operatingsystemmajrelease >= 7 {
          fail("Class['oraaud::install']: Unsupported operating system majrelease ${::operatingsystemmajrelease}")
        }
      }
      default: {
         fail("Class['oraaud::install']: Unsupported osfamily: ${::osfamily}")
       }
   }

   exec { "cp -a $src_dir/$tarfile .":
      cwd       => "$dir_tmp",
      path      => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
      creates   => "$dir_tmp/$tarfile",
      unless    => "ls $dir_dest",
      logoutput => "true",
   }
   exec { "tar xzf $tarfile":
      cwd       => "$dir_tmp",
      path      => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin",
      unless    => "ls $dir_dest",
      creates   => "$dir_tmp/$untar",
      logoutput => "true",
   }
   exec { "itm630agent_rhel.sh $itm_server $src_dir/$itm_dir":
      cwd       => "$dir_tmp/$script_dir",
      path      => "/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin:$dir_tmp/$script_dir",
      onlyif    => "ls $src_dir/$itm_dir",
      creates   => "$itm_home/bin/cinfo",
      logoutput => "true",
   }

}

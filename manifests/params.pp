class oraaud::params {

  # dir_src             : path to install files
  $dir_src              = '/fslink/sysinfra/oracle/scripts/misc/auditing'
  $dir_audit            = '/home/oracle/system/audit'
  $script_audit         = 'install_ora_audit.sh'
  $script_compare       = 'version_compare.sh'
  $script_cycle_db      = 'cycle_db.sh'
  $script_marker_rm     = 'marker_rm.sh'
  $file_tar             = 'rn-ora_audit_nitc.tar'
  $path_default         = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin'
  $expect_package       = 'expect'
  $expect_ensure        = 'present'
  $db_user              = 'oracle'
  $db_group             = 'oinstall'

}

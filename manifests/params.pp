class oraaud::params {

  # dir_src             : path to install files
  $dir_src              = '/fslink/sysinfra/oracle/scripts/misc/auditing'
  $dir_audit            = '/home/oracle/system/audit'
  $script_audit         = 'install_ora_audit.sh'
  $script_compare       = 'version_compare.sh'
  $file_tar             = 'rn-ora_audit_nitc.tar'
  $expect_package       = 'expect'
  $expect_ensure        = 'present'
  $db_user              = 'oracle'

}

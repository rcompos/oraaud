# == Class: oraaud
class oraaud (
  String $dir_src             = '/fslink/sysinfra/oracle/scripts/misc/auditing',
  String $dir_audit           = '/home/oracle/system/audit',
  String $script_audit        = 'install_ora_audit.sh',
  String $script_compare      = 'version_compare.sh',
  String $script_cycle_db     = 'cycle_db.sh',
  String $script_marker_rm    = 'marker_rm.sh',
  String $file_tar            = 'rn-ora_audit_nitc.tar',
  String $path_default        = '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
  String $expect_package      = 'expect',
  String $expect_ensure       = 'present',
  String $db_user             = 'oracle',
  String $db_group            = 'oinstall',
  Optional[String] $scp_pw    = hiera('scp_pw',undef),
) {

  anchor { 'oraaud::begin': }     ->
  class  { 'oraaud::prereq': }    ->
  class  { 'oraaud::install': }   ->
  class  { 'oraaud::service': }   ->
  anchor { 'oraaud::end': }

}

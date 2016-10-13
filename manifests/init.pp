# == Class: oraaud
class oraaud (
  String $dir_src             = ::profile::oracle::oracle_audit::dir_src,
  String $dir_audit           = ::profile::oracle::oracle_audit::dir_audit,
  String $script_audit        = ::profile::oracle::oracle_audit::script_audit,
  String $script_compare      = ::profile::oracle::oracle_audit::script_compare,
  String $script_cycle_db     = ::profile::oracle::oracle_audit::script_cycle_db,
  String $script_marker_rm    = ::profile::oracle::oracle_audit::script_marker_rm,
  String $file_tar            = ::profile::oracle::oracle_audit::file_tar,
  String $path_default        = ::profile::oracle::oracle_audit::path_default,
  String $expect_package      = ::profile::oracle::oracle_audit::expect_package,
  String $expect_ensure       = ::profile::oracle::oracle_audit::expect_ensure,
  String $db_user             = ::profile::oracle::oracle_audit::db_user,
  String $db_group            = ::profile::oracle::oracle_audit::db_group,
  Optional[String] $scp_pw    = hiera('scp_pw',undef),
) {

  anchor { 'oraaud::begin': }     ->
  class  { 'oraaud::prereq': }    ->
  class  { 'oraaud::install': }   ->
  class  { 'oraaud::service': }   ->
  anchor { 'oraaud::end': }

}

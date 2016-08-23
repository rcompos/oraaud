# == Class: oraaud
class oraaud (
  String $dir_src          = ::oraaud::params::dir_src,
  String $dir_audit        = ::oraaud::params::dir_audit,
  String $script_audit     = ::oraaud::params::script_audit,
  String $script_compare   = ::oraaud::params::script_compare,
  String $script_cycle_db  = ::oraaud::params::script_cycle_db,
  String $script_marker_rm = ::oraaud::params::script_marker_rm,
  String $file_tar         = ::oraaud::params::file_tar,
  String $path_default     = ::oraaud::params::path_default,
  String $expect_package   = ::oraaud::params::expect_package,
  String $expect_ensure    = ::oraaud::params::expect_ensure,
  String $db_user          = ::oraaud::params::db_user,
  String $db_group         = ::oraaud::params::db_group,
  Optional[String] $scp_pw = ::oraaud::params::scp_pw,

) inherits ::oraaud::params {

  anchor { 'oraaud::begin': }     ->
  class  { '::oraaud::prereq': }  ->
  class  { '::oraaud::install': } ->
  class  { '::oraaud::service': } ->
  anchor { 'oraaud::end': }

}

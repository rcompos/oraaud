# == Class: oraaud
class oraaud (
  String $dir_src,
  String $dir_audit,
  String $script_audit,
  String $script_compare,
  String $script_cycle_db,
  String $script_marker_rm,
  String $file_tar,
  String $path_default,
  String $expect_package,
  String $expect_ensure,
  String $db_user,
  String $db_group,
  Optional[String] $scp_pw,
) {

  anchor { 'oraaud::begin': }     ->
  class  { '::oraaud::prereq': }  ->
  class  { '::oraaud::install': } ->
  class  { '::oraaud::service': } ->
  anchor { 'oraaud::end': }

}

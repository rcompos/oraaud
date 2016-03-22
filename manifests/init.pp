# == Class: oraaud
class oraaud (

  $aud_server          = $oraaud::params::aud_server,
  $src_dir             = $oraaud::params::src_dir,

) inherits oraaud::params {

  validate_string($aud_server)
  validate_string($src_dir)

  anchor { 'oraaud::begin': }     ->
  class  { '::oraaud::install': } ->
  #class  { '::oraaud::config': }  ~>
  class  { '::oraaud::service': } ->
  anchor { 'oraaud::end': }

}

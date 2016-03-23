# == Class: oraaud
class oraaud (

) inherits oraaud::params {

  anchor { 'oraaud::begin': }     ->
  class  { '::oraaud::install': } ->
  #class  { '::oraaud::config': }  ~>
  #class  { '::oraaud::service': } ->
  anchor { 'oraaud::end': }

}

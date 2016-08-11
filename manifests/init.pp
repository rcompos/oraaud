# == Class: oraaud
class oraaud (

) inherits oraaud::params {

  anchor { 'oraaud::begin': }     ->
  class  { '::oraaud::prereq': }  ->
  class  { '::oraaud::install': } ->
  class  { '::oraaud::service': } ->
  anchor { 'oraaud::end': }

}

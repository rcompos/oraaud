# Class: ora_audit
# ===========================
#
# Full description of class ora_audit here.
#
# Parameters
# ----------
#
# * `sample parameter`
#   Explanation of what this parameter affects and what it defaults to.
#   e.g. "Specify one or more upstream ntp servers as an array."
#
class ora_audit (
  $package_name = $::ora_audit::params::package_name,
  $service_name = $::ora_audit::params::service_name,
) inherits ::ora_audit::params {

  # validate parameters here

  class { '::ora_audit::install': } ->
  class { '::ora_audit::config': } ~>
  class { '::ora_audit::service': } ->
  Class['::ora_audit']
}

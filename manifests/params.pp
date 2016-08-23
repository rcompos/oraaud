# == Class ora_audit::params
#
# This class is meant to be called from ora_audit.
# It sets variables according to platform.
#
class ora_audit::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'ora_audit'
      $service_name = 'ora_audit'
    }
    'RedHat', 'Amazon': {
      $package_name = 'ora_audit'
      $service_name = 'ora_audit'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

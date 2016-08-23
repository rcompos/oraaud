# == Class ora_audit::install
#
# This class is called from ora_audit for install.
#
class ora_audit::install {

  package { $::ora_audit::package_name:
    ensure => present,
  }
}

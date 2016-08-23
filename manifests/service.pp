# == Class ora_audit::service
#
# This class is meant to be called from ora_audit.
# It ensure the service is running.
#
class ora_audit::service {

  service { $::ora_audit::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

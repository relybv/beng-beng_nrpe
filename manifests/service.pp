# == Class beng_nrpe::service
#
# This class is meant to be called from beng_nrpe.
# It ensure the service is running.
#
class beng_nrpe::service {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  service { $::beng_nrpe::service_name:
    ensure     => running,
    enable     => true,
    hasstatus  => true,
    hasrestart => true,
  }
}

# == Class beng_nrpe::install::rh6
#
# This class is meant to be called from beng_nrpe.
# It ensure the service is running.
#
class beng_nrpe::install::rh6 {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }


}

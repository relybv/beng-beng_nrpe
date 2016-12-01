# == Class beng_nrpe::install
#
# This class is called from beng_nrpe for install.
#
class beng_nrpe::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  package { $::beng_nrpe::package_name:
    ensure => present,
  }
}

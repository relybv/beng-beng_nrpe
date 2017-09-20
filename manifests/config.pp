# == Class beng_nrpe::config
#
# This class is called from beng_nrpe for service config.
#
class beng_nrpe::config {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  case $::osfamily {
    'RedHat', 'CentOs': {
      case $::operatingsystemrelease {
        /^6.*/: {
          class { 'beng_nrpe::config::rh6': }
        }
        /^7.*/: {
          class { 'beng_nrpe::config::rh7': }
        }
        default: {
          fail("${::operatingsystemrelease} not supported")
        }
      }
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

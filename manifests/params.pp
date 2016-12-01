# == Class beng_nrpe::params
#
# This class is meant to be called from beng_nrpe.
# It sets variables according to platform.
#
class beng_nrpe::params {
  case $::osfamily {
    'Debian': {
      $package_name = 'beng_nrpe'
      $service_name = 'beng_nrpe'
    }
    'RedHat', 'Amazon': {
      $package_name = 'beng_nrpe'
      $service_name = 'beng_nrpe'
    }
    default: {
      fail("${::operatingsystem} not supported")
    }
  }
}

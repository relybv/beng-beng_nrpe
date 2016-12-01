# == Class: beng_nrpe
#
# Full description of class beng_nrpe here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class beng_nrpe
(
  $package_name = $::beng_nrpe::params::package_name,
  $service_name = $::beng_nrpe::params::service_name,
) inherits ::beng_nrpe::params {

  # validate parameters here
  validate_string($package_name)
  validate_string($service_name)

  class { '::beng_nrpe::install': } ->
  class { '::beng_nrpe::config': } ~>
  class { '::beng_nrpe::service': } ->
  Class['::beng_nrpe']
}

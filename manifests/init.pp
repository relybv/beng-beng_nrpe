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
  $service_name = $::beng_nrpe::params::service_name,
  $baseurl = $::beng_nrpe::params::baseurl,
  $snmp_network = $::beng_nrpe::params::snmp_network,
  $snmp_contact = $::beng_nrpe::params::snmp_contact,
  $snmp_location = $::beng_nrpe::params::snmp_location,
  $packages = $::beng_nrpe::params::packages
  
  class { '::profile_base':
    tcp_extra_rule2        => true,
    tcp_extra_rule2_dport  => 5666,
    tcp_extra_rule2_source => '0.0.0.0/0',
  }
) inherits ::beng_nrpe::params {

  # validate parameters here
  validate_string($service_name)

  class { '::beng_nrpe::install': } ->
  class { '::beng_nrpe::config': } ~>
  class { '::beng_nrpe::service': } ->
  Class['::beng_nrpe']
}

# == Class beng_nrpe::install
#
# This class is called from beng_nrpe for install.
#
class beng_nrpe::install {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  $rpmurl="${beng_nrpe::baseurl}/nrpe-complied-rhel6/"
  $configurl="${beng_nrpe::baseurl}/nrpe.cfg"
  $checkurl="${beng_nrpe::baseurl}/bronze/local_commands.cfg"

  # install packages
  ensure_packages( $beng_nrpe::packages  )

  exec{ 'retrieve_checks':
    command => "/usr/bin/wget -q ${checkurl} -O /usr/local/nrpe/etc/bronze/local_commands.cfg",
    notify  => Service[ $::beng_nrpe::service_name ],
  }->

  exec{ 'retrieve_config':
    command => "/usr/bin/wget -q ${configurl} -O /usr/local/nrpe/etc/nrpe.cfg",
    notify  => Service[ $::beng_nrpe::service_name ],
  }

  class { 'snmp':
    agentaddress => [ 'udp:161', ],
    ro_community => 'public',
    ro_network   => $beng_nrpe::snmp_network,
    contact      => $beng_nrpe::snmp_contact,
    location     => $beng_nrpe::snmp_location,
  }
}

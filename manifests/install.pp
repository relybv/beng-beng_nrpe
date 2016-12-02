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

  package { [ 'perl-Digest-HMAC', 'perl-Digest-SHA1']:
    ensure => installed,
  }->

  package { 'perl-Crypt-DES':
    ensure   => installed,
    provider => rpm,
    source   => "${rpmurl}/perl-Crypt-DES-2.05-9.el6.x86_64.rpm",
  }->

  package { 'perl-Net-SNMP':
    ensure   => installed,
    provider => rpm,
    source   => "${rpmurl}/perl-Net-SNMP-5.2.0-4.el6.noarch.rpm",
  }->

  package { 'vdl-nagios-common':
    ensure   => installed,
    provider => rpm,
    source   => "${rpmurl}/vdl-nagios-common-3.2-3.noarch.rpm",
  }->

  package { 'vdl-nagios-plugins':
    ensure   => installed,
    provider => rpm,
    source   => "${rpmurl}/vdl-nagios-plugins-1.4.15-2.x86_64.redhat.rpm",
  }->

  package { 'vdl-nrpe':
    ensure   => installed,
    provider => rpm,
    source   => "${rpmurl}/vdl-nrpe-2.12-4.x86_64.redhat.rpm",
  }->

  package { 'vdl-nrpe-plugin':
    ensure   => installed,
    provider => rpm,
    source   => "${rpmurl}/vdl-nrpe-plugin-2.12-4.x86_64.redhat.rpm",
  }->

  exec{ 'retrieve_checks':
    command => "/usr/bin/wget -q ${checkurl} -O /usr/local/nrpe/etc/bronze/local_commands.cfg",
    notify  => Service[ 'nrpe' ],
  }->

  exec{ 'retrieve_config':
    command => "/usr/bin/wget -q ${configurl} -O /usr/local/nrpe/etc/nrpe.cfg",
    notify  => Service[ 'nrpe' ],
  }

  class { 'snmp':
    agentaddress => [ 'udp:161', ],
    ro_community => 'public',
    ro_network   => $beng_nrpe::snmp_network,
    contact      => $beng_nrpe::snmp_contact,
    location     => $beng_nrpe::snmp_location,
  }
}

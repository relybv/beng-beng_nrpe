# == Class beng_nrpe::install::rh7
#
# This class is meant to be called from beng_nrpe.
# It ensure the service is running.
#
class beng_nrpe::install::rh7 {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # install repository
  yumrepo { 'epel-latest-7':
    enabled    => 1,
    descr      => 'Extra Packages for Enterprise Linux 7',
    baseurl    => 'http://download.fedoraproject.org/pub/epel/7/x86_64',
    mirrorlist => 'https://mirrors.fedoraproject.org/metalink?repo=epel-7&arch=$basearch',
    gpgcheck   => 0,
  }

  # install nrpe and plugins
  package { [ 'nagios-plugins-all', 'nrpe' ]:
    ensure  => installed,
    require => Yumrepo[ 'epel-latest-7' ],
  }

  # install configuration files
  file { '/etc/nagios/nrpe.cfg':
    notify  => Service[$::beng_nrpe::service_name],
    source => 'puppet:///modules/beng_nrpe/nrpe.cfg',
  }

  file { '/etc/nrpe.d/local_commands.cfg':
    notify  => Service[$::beng_nrpe::service_name],
    source  => 'puppet:///modules/beng_nrpe/local_commands.cfg',
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/usr/lib64/nagios/plugins/utils.sh':
    notify  => Service[$::beng_nrpe::service_name],
    source  => 'puppet:///modules/beng_nrpe/utils.sh',
    mode    => '0755',
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/usr/lib64/nagios/plugins/check_memory.sh':
    notify  => Service[$::beng_nrpe::service_name],
    source  => 'puppet:///modules/beng_nrpe/check_memory.sh',
    mode    => '0755',
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/usr/lib64/nagios/plugins/check_uptime.sh':
    notify  => Service[$::beng_nrpe::service_name],
    source  => 'puppet:///modules/beng_nrpe/check_uptime.sh',
    mode    => '0755',
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

}

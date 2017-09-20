# == Class beng_nrpe::config::rh7
#
# This class is meant to be called from beng_nrpe.
# It ensure the service is running.
#
class beng_nrpe::config::rh7 {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  # install configuration files
  file { '/etc/nagios/nrpe.cfg':
    ensure  => 'present',
    source  => 'puppet:///modules/beng_nrpe/nrpe.cfg',
    notify  => Service[ $::beng_nrpe::service_name ],
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/etc/nrpe.d/local_commands.cfg':
    source  => 'puppet:///modules/beng_nrpe/local_commands.cfg',
    notify  => Service[ $::beng_nrpe::service_name ],
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/usr/lib64/nagios/plugins/utils.sh':
    source  => 'puppet:///modules/beng_nrpe/utils.sh',
    mode    => '0755',
    notify  => Service[ $::beng_nrpe::service_name ],
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/usr/lib64/nagios/plugins/check_memory.sh':
    source  => 'puppet:///modules/beng_nrpe/check_memory.sh',
    mode    => '0755',
    notify  => Service[ $::beng_nrpe::service_name ],
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }

  file { '/usr/lib64/nagios/plugins/check_uptime.sh':
    source  => 'puppet:///modules/beng_nrpe/check_uptime.sh',
    mode    => '0755',
    notify  => Service[ $::beng_nrpe::service_name ],
    require => Package[ 'nagios-plugins-all', 'nrpe' ],
  }
}

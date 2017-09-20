# == Class beng_nrpe::config::rh6
#
# This class is meant to be called from beng_nrpe.
# It ensure the service is running.
#
class beng_nrpe::config::rh6 {
  # prevent direct use of subclass
  if $caller_module_name != $module_name {
    fail("Use of private class ${name} by ${caller_module_name}")
  }

  exec{ 'retrieve_checks':
    command => "/usr/bin/wget -q ${beng_nrpe::checkurl} -O /usr/local/nrpe/etc/bronze/local_commands.cfg",
    notify  => Service[ $::beng_nrpe::service_name ],
  }

  -> exec{ 'retrieve_config':
    command => "/usr/bin/wget -q ${beng_nrpe::configurl} -O /usr/local/nrpe/etc/nrpe.cfg",
    notify  => Service[ $::beng_nrpe::service_name ],
  }

}

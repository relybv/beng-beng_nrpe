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

  # install nrpe

  # install plugins

  # install configuration files

}

# == Class beng_nrpe::params
#
# This class is meant to be called from beng_nrpe.
# It sets variables according to platform.
#
class beng_nrpe::params {
  $service_name = 'nrpe'
  $baseurl = 'http://s404.ka.beeldengeluid.nl/nagios/depot/lin'
  $snmp_network ='172.19.53.17'
  $snmp_contact = 'servicedesk@beeldengeluid.nl'
  $snmp_location = 'Beeld en Geluid'
}

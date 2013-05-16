# Class: bind::params
#
class bind::params {

  case $::operatingsystem {
    'RedHat',
    'CentOS',
    'Amazon': {
      $packagenameprefix  = 'bind'
      $servicename        = 'named'
      $binduser           = 'root'
      $bindgroup          = 'named'
      $rootns_file        = 'named.ca'
      $rfc1912_file       = '/etc/named.rfc1912.zones'
      $directory          = '/var/named'
    }
    'Debian',
    'Ubuntu': {
      $packagenameprefix  = 'bind9'
      $servicename        = 'bind9'
      $binduser           = 'bind'
      $bindgroup          = 'bind'
      $rootns_file        = '/etc/bind/db.root'
      $rfc1912_file       = '/etc/bind/zones.rfc1918'
      $directory          = '/var/cache/bind'
    }
    default: {
      $packagenameprefix  = 'bind'
      $servicename        = 'named'
      $binduser           = 'root'
      $bindgroup          = 'named'
      $rootns_file        = 'named.ca'
      $rfc1912_file       = '/etc/named.rfc1912.zones'
      $directory          = '/var/named'
    }
  }

}

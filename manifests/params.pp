# Class: bind::params
#
class bind::params {

  case $::operatingsystem {
    'RedHat',
    'CentOS',
    'Amazon': {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $directory         = '/var/named'
      $root_servers_file = 'named.ca'
      $includes          = ['/etc/named.rfc1912.zones']
      $logging           = 'yes'
      $logfile           = '/var/log/named/named.log'
    }
    'Debian',
    'Ubuntu': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $directory         = '/var/cache/bind'
      $logging           = 'no'
      $logfile           = '/var/log/bind/named.log'
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $directory         = '/var/named'
      $root_servers_file = 'named.ca'
      $logging           = 'yes'
      $logfile           = '/var/log/named/named.log'
    }
  }

}


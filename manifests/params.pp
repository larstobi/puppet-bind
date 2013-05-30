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
      $conf_dir          = '/etc'
      $directory         = '/var/named'
      $root_servers_file = 'named.ca'
      $includes          = ['/etc/named.rfc1912.zones']
      $logging           = 'yes'
      $logfile           = '/var/log/named/named.log'
      $dnssec_enable     = 'yes'
      $dnssec_validation = 'yes'
      $bindkeys_file     = '/etc/named.iscdlv.key'
      $initd_opt_file    = '/etc/sysconfig/named'
      $initd_opt_templ   = "${module_name}/sysconfig-named.erb"
    }
    'Debian',
    'Ubuntu': {
      $packagenameprefix = 'bind9'
      $servicename       = 'bind9'
      $binduser          = 'bind'
      $bindgroup         = 'bind'
      $conf_dir          = '/etc/bind'
      $directory         = '/var/cache/bind'
      $includes          = ['/etc/bind/zones.rfc1918']
      $logging           = 'no'
      $logfile           = '/var/log/bind/named.log'
      $initd_opt_file    = '/etc/default/bind9'
      $initd_opt_templ   = "${module_name}/default-bind9.erb"
    }
    default: {
      $packagenameprefix = 'bind'
      $servicename       = 'named'
      $binduser          = 'root'
      $bindgroup         = 'named'
      $conf_dir          = '/etc'
      $directory         = '/var/named'
      $root_servers_file = 'named.ca'
      $logging           = 'yes'
      $logfile           = '/var/log/named/named.log'
      $initd_opt_file    = '/etc/sysconfig/named'
      $initd_opt_templ   = "${module_name}/sysconfig-named.erb"
    }
  }

}


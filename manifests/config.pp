# Define: bind::server::conf
#
# ISC BIND server template-based configuration definition.
#
# Parameters:
#  $acls:
#   Hash of client ACLs, name as key and array of config lines. Default: empty
#  $masters:
#   Hash of master ACLs, name as key and array of config lines. Default: empty
#  $listen_on_port:
#   IPv4 port to listen on. Set to false to disable. Default: '53'
#  $listen_on_addr:
#   Array of IPv4 addresses to listen on. Default: [ '127.0.0.1' ]
#  $listen_on_v6_port:
#   IPv6 port to listen on. Set to false to disable. Default: '53'
#  $listen_on_v6_addr:
#   Array of IPv6 addresses to listen on. Default: [ '::1' ]
#  $forwarders:
#   Array of forwarders IP addresses. Default: empty
#  $directory:
#   Base directory for the BIND server. Default: '/var/named'
#  $version:
#   Version string override text. Default: none
#  $dump_file:
#   Dump file for the server. Default: '/var/named/data/cache_dump.db'
#  $statistics_file:
#   Statistics file for the server. Default: '/var/named/data/named_stats.txt'
#  $memstatistics_file:
#   Memory statistics file for the server.
#   Default: '/var/named/data/named_mem_stats.txt'
#  $allow_query:
#   Array of IP addrs or ACLs to allow queries from. Default: [ 'localhost' ]
#  $recursion:
#   Allow recursive queries. Default: 'yes'
#  $allow_recursion:
#   Array of IP addrs or ACLs to allow recursion from. Default: empty
#  $allow_transfer:
#   Array of IP addrs or ACLs to allow transfer to. Default: empty
#  $check_names:
#   Array of check-names strings. Example: [ 'master ignore' ]. Default: empty
#  $dnssec_enable:
#   Enable DNSSEC support. Default: 'yes'
#  $dnssec_validation:
#   Enable DNSSEC validation. Default: 'yes'
#  $dnssec_lookaside:
#   DNSSEC lookaside type. Default: 'auto'
#  $zones:
#   Hash of managed zones and their configuration. The key is the zone name
#   and the value is an array of config lines. Default: empty
#  $includes:
#   Array of absolute paths to named.conf include files. Default: empty
#
# Sample Usage :
#  bind::server::conf { '/etc/named.conf':
#    acls => {
#      'rfc1918' => [ '10/8', '172.16/12', '192.168/16' ],
#    },
#    masters => {
#      'mymasters' => [ '192.0.2.1', '198.51.100.1' ],
#    },
#    zones => {
#      'example.com' => [
#        'type master',
#        'file "example.com"',
#      ],
#      'example.org' => [
#        'type slave',
#        'file "slaves/example.org"',
#        'masters { mymasters; }',
#      ],
#    }
#  }
#
class bind::config (
  $acls               = {},
  $masters            = {},
  $listen_on_port     = '53',
  $listen_on_addr     = [ '127.0.0.1' ],
  $ipv4_only          = 'no',
  $listen_on_v6       = 'yes',
  $listen_on_v6_port  = '53',
  $listen_on_v6_addr  = [ '::1' ],
  $forwarders         = [],
  $conf_dir           = $bind::params::conf_dir,
  $directory          = $bind::params::directory,
  $root_servers_file  = $bind::params::root_servers_file,
  $version            = undef,
  $dump_file          = 'cache_dump.db',
  $statistics_file    = 'named_stats.txt',
  $memstatistics_file = 'named_mem_stats.txt',
  $allow_query        = [ 'localhost' ],
  $allow_query_cache  = [],
  $recursion          = 'yes',
  $allow_recursion    = [],
  $allow_transfer     = [],
  $check_names        = [],
  $dnssec_enable      = $bind::params::dnssec_enable,
  $dnssec_validation  = $bind::params::dnssec_validation,
  $dnssec_lookaside   = 'auto',
  $zones              = {},
  $logging            = $bind::params::logging,
  $includes           = $bind::params::includes,
  $initd_opt_file     = $bind::params::initd_opt_file,
  $initd_opt_templ    = $bind::params::initd_opt_templ,

) {
  File {
    notify  => Class['bind::service'],
  }

  # # We want a nice log file which the package doesn't provide a location for
  # $bindlogdir = $chroot ? {
  #   true  => '/var/named/chroot/var/log/named',
  #   false => '/var/log/named',
  # }
  $logdir = '/var/log/bind'
  $logfile = '/var/log/bind/named.log'
  file { $logdir:
    require => Class['bind::package'],
    ensure  => directory,
    owner   => $bind::params::binduser,
    group   => $bind::params::bindgroup,
    mode    => '0770',
  }

  file {
    $initd_opt_file:
      ensure => present,
      content => template($initd_opt_templ);
  }

  file {
    "${conf_dir}/named.conf.local":
      content => template('bind/named.conf.erb');

    "${conf_dir}/named.conf.options":
      content => template('bind/named.conf.options.erb');
  }


}


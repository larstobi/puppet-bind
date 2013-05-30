# Class: bind::package
#
class bind::package (
  $packagenameprefix = $bind::params::packagenameprefix,
  $packagenamesuffix = ''
) {

  package { "${packagenameprefix}${packagenamesuffix}": ensure => installed }

}


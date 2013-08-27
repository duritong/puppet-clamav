# setup clamav
class clamav::base {
  package{'clamav':
    ensure => installed,
  }

  service{'clamd':
    ensure    => running,
    enable    => true,
    hasstatus => true,
    require   => Package['clamav'],
  }

  file{
    '/etc/clamd.conf':
      source  => [ "puppet:///modules/site_clamav/${::fqdn}/clamd.conf",
                  "puppet:///modules/site_clamav/clamd.conf.${::operatingsystem}.${::lsbdistcodename}",
                  "puppet:///modules/site_clamav/clamd.conf.${::operatingsystem}",
                  'puppet:///modules/site_clamav/clamd.conf',
                  "puppet:///modules/clamav/clamd.conf.${::operatingsystem}.${::lsbdistcodename}",
                  "puppet:///modules/clamav/clamd.conf.${::operatingsystem}",
                  'puppet:///modules/clamav/clamd.conf' ],
      require => Package['clamav'],
      notify  => Service['clamd'],
      owner   => root,
      group   => 0,
      mode    => '0644';
    '/etc/freshclam.conf':
      source  => [ "puppet:///modules/site_clamav/${::fqdn}/freshclam.conf",
                  "puppet:///modules/site_clamav/freshclam.conf.${::operatingsystem}.${::lsbdistcodename}",
                  "puppet:///modules/site_clamav/freshclam.conf.${::operatingsystem}",
                  'puppet:///modules/site_clamav/freshclam.conf',
                  "puppet:///modules/clamav/freshclam.conf.${::operatingsystem}.${::lsbdistcodename}",
                  "puppet:///modules/clamav/freshclam.conf.${::operatingsystem}",
                  'puppet:///modules/clamav/freshclam.conf' ],
      require => Package['clamav'],
      owner   => root,
      group   => 0,
      mode    => '0644':
  }
}

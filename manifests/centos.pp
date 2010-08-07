class clamav::centos inherits clamav::base {
  require amavisd-new

  Service['clamd']{
    name => 'clamd.amavisd',
    hasstatus => true
  }

  file{'/etc/sysconfig/freshclam':
    source => [ "puppet:///modules/site-clamav/sysconfig/${fqdn}/freshclam",
                "puppet:///modules/site-clamav/sysconfig/freshclam",
                "puppet:///modules/clamav/sysconfig/freshclam" ],
    require => Package['clamav-update'],
    owner => root, group => root, mode => 0644;
  }

  file{'/etc/cron.d/clamav-update':
    source => [ "puppet:///modules/site-clamav/cron.d/${fqdn}/clamav-update",
                "puppet:///modules/site-clamav/cron.d/clamav-update",
                "puppet:///modules/clamav/cron.d/clamav-update" ],
    require => Package['clamav-update'],
    owner => root, group => root, mode => 0600;
  }

  package{'clamav-update':
    ensure => present,
  }

  File['/etc/clamd.conf']{
    source => undef,
    ensure => absent
  }

  File['/etc/freshclam.conf']{
    require +> Package['clamav-update']
  }
}

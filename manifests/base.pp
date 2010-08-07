class clamav::base {
  package{clamav:
    ensure => installed,
  }

  service{'clamd':
    ensure => running,
    enable => true,
    hasstatus => true,
    require => Package['clamav'],
  }

  file{'/etc/clamd.conf':
    source => [ "puppet:///modules/site-clamav/${fqdn}/clamd.conf",
                "puppet:///modules/site-clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet:///modules/site-clamav/clamd.conf.${operatingsystem}",
                "puppet:///modules/site-clamav/clamd.conf",
                "puppet:///modules/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet:///modules/clamav/clamd.conf.${operatingsystem}",
                "puppet:///modules/clamav/clamd.conf" ],
    require => Package['clamav'],
    owner => root, group => 0, mode => 0644;
  }
  file{'/etc/freshclam.conf':
    source => [ "puppet:///modules/site-clamav/${fqdn}/freshclam.conf",
                "puppet:///modules/site-clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet:///modules/site-clamav/freshclam.conf.${operatingsystem}",
                "puppet:///modules/site-clamav/freshclam.conf",
                "puppet:///modules/clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet:///modules/clamav/freshclam.conf.${operatingsystem}",
                "puppet:///modules/clamav/freshclam.conf" ],
    require => Package['clamav'],
    owner => root, group => 0, mode => 0644,
  }
}

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
    source => [ "puppet://$server/modules/site-clamav/${fqdn}/clamd.conf",
                "puppet://$server/modules/site-clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet://$server/modules/site-clamav/clamd.conf.${operatingsystem}",
                "puppet://$server/modules/site-clamav/clamd.conf",
                "puppet://$server/modules/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet://$server/modules/clamav/clamd.conf.${operatingsystem}",
                "puppet://$server/modules/clamav/clamd.conf" ],
    require => Package['clamav'],
    owner => root, group => 0, mode => 0644;
  }
  file{'/etc/freshclam.conf':
    source => [ "puppet://$server/modules/site-clamav/${fqdn}/freshclam.conf",
                "puppet://$server/modules/site-clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet://$server/modules/site-clamav/freshclam.conf.${operatingsystem}",
                "puppet://$server/modules/site-clamav/freshclam.conf",
                "puppet://$server/modules/clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                "puppet://$server/modules/clamav/freshclam.conf.${operatingsystem}",
                "puppet://$server/modules/clamav/freshclam.conf" ],
    require => Package['clamav'],
    owner => root, group => 0, mode => 0644,
  }
}

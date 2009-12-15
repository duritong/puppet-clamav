class clamav::base {

    package{clamav:
        ensure => installed,
        require => Class[amavisd-new],
    }

    case $operatingsystem {
      debian: {$clamd_servicename = "clamav-daemon" }
      default: {$clamd_servicename="clamd"}
      }


    service{clamd:
	name => $clamd_servicename,
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package[clamav],
    }

    file{'/etc/clamd.conf':
        source => [ "puppet://$server/modules/site-clamav/${fqdn}/clamd.conf",
                    "puppet://$server/modules/site-clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/modules/site-clamav/clamd.conf.${operatingsystem}",
                    "puppet://$server/modules/site-clamav/clamd.conf",
                    "puppet://$server/modules/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/modules/clamav/clamd.conf.${operatingsystem}",
                    "puppet://$server/modules/clamav/clamd.conf" ],
        owner => root,
        group => 0,
        mode => 0644,
        require => Package[clamav],
    }
    file{'/etc/freshclam.conf':
        source => [ "puppet://$server/modules/site-clamav/${fqdn}/freshclam.conf",
                    "puppet://$server/modules/site-clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/modules/site-clamav/freshclam.conf.${operatingsystem}",
                    "puppet://$server/modules/site-clamav/freshclam.conf",
                    "puppet://$server/modules/clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/modules/clamav/freshclam.conf.${operatingsystem}",
                    "puppet://$server/modules/clamav/freshclam.conf" ],
        owner => root,
        group => 0,
        mode => 0644,
        require => Package[clamav],
    }
    file {'/var/run/clamav':
        ensure => directory,
        owner => clamav,
        # user => clamav,  ?
        mode => 0755,
        require => Package[clamav],
    }

}

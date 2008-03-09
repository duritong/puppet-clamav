# modules/clamav/manifests/init.pp - manage clamav stuff
# Copyright (C) 2007 admin@immerda.ch
#

# modules_dir { "clamav": }


class clamav {
    case $operatingsystem {
        gentoo: {include clamav::gentoo}
        default: {include clamav::base}
    }
}

class clamav::base {

    package{clamav:
        ensure => installed,
    }

    service{clamav:
        ensure => running,
        enable => true,
        hasstatus => true,
    }

    file{'/etc/clamd.conf':
        source => [ "puppet://$server/dist/clamav/${fqdn}/clamd.conf",
                    "puppet://$server/dist/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/dist/clamav/clamd.conf.${operatingsystem}",
                    "puppet://$server/dist/clamav/clamd.conf",
                    "puppet://$server/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/clamav/clamd.conf.${operatingsystem}",
                    "puppet://$server/clamav/clamd.conf" ]
        owner => root,
        group => 0,
        mode => 0644,
        require => Package[clamav],
    }
    file{'/etc/freshclam.conf':
        source => [ "puppet://$server/dist/clamav/${fqdn}/freshclam.conf",
                    "puppet://$server/dist/clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/dist/clamav/freshclam.conf.${operatingsystem}",
                    "puppet://$server/dist/clamav/freshclam.conf",
                    "puppet://$server/clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/clamav/freshclam.conf.${operatingsystem}",
                    "puppet://$server/clamav/freshclam.conf" ]
        owner => root,
        group => 0,
        mode => 0644,
        require => Package[clamav],
    }
    file{'/var/run/clamav':
        ensure => directory,
        owner => clamav,
        user => clamav,
        mode => 0755,
        require => Package[clamav],
    }

}

class clamav::gentoo inherits clamav::base {
    Package[clamav]{
        category => 'app-antivirus',
        notify => Exec[fix_clamav_group],
    }

    exec{'fix_clamav_group':
        command => 'gpasswd -a clamav amavis',
        refreshonly => true,
    }
}

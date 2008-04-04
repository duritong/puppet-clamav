# modules/clamav/manifests/init.pp - manage clamav stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# this module requires the amavisd-new module
# this module is part of a whole bunch of modules, please have a look at the exim module
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
        require => Class[amavisd-new],
    }

    service{clamd:
        ensure => running,
        enable => true,
        hasstatus => true,
        require => Package[clamav],
    }

    file{'/etc/clamd.conf':
        source => [ "puppet://$server/files/clamav/${fqdn}/clamd.conf",
                    "puppet://$server/files/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/files/clamav/clamd.conf.${operatingsystem}",
                    "puppet://$server/files/clamav/clamd.conf",
                    "puppet://$server/clamav/clamd.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/clamav/clamd.conf.${operatingsystem}",
                    "puppet://$server/clamav/clamd.conf" ]
        owner => root,
        group => 0,
        mode => 0644,
        require => Package[clamav],
    }
    file{'/etc/freshclam.conf':
        source => [ "puppet://$server/files/clamav/${fqdn}/freshclam.conf",
                    "puppet://$server/files/clamav/freshclam.conf.${operatingsystem}.${lsbdistcodename}",
                    "puppet://$server/files/clamav/freshclam.conf.${operatingsystem}",
                    "puppet://$server/files/clamav/freshclam.conf",
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
    #conf.d file if needed
    Service[clamd]{
        require +> File["/etc/conf.d/clamd"],
    }
    file { "/etc/conf.d/clamd":
        owner => "root",
        group => "0",
        mode  => 644,
        ensure => present,
        source => [
            "puppet://$server/files/clamav/conf.d/${fqdn}/clamd",
            "puppet://$server/files/clamav/conf.d/clamd",
            "puppet://$server/clamav/conf.d/clamd"
        ]
    }
}

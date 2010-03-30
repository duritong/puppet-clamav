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
    source => [
      "puppet://$server/modules/site-clamav/conf.d/${fqdn}/clamd",
      "puppet://$server/modules/site-clamav/conf.d/clamd",
      "puppet://$server/modules/clamav/conf.d/clamd"
    ],
    ensure => present,
    owner => root, group => 0, mode  => 644;
  }
  file {'/var/run/clamav':
    ensure => directory,
    require => Package['clamav'],
    before => Service['clamd'],
    owner => clamav, group => 0, mode => 0755;
  }
}

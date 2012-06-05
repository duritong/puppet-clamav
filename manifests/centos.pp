class clamav::centos inherits clamav::base {
  require amavisd_new

  file{'/var/run/clamd.amavisd':
    ensure => directory,
    owner => amavis, group => 0, mode => 0700;
  }

  Service['clamd']{
    name => 'clamd.amavisd',
    hasstatus => true,
    require => File['/var/run/clamd.amavisd'],
  }

  File['/etc/clamd.conf']{
    source => undef,
    ensure => absent
  }
}

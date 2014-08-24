# centos specific changes
class clamav::centos inherits clamav::base {
  require amavisd_new

  Service['clamd']{
    name      => 'clamd.amavisd',
    hasstatus => true,
  }

  File['/etc/clamd.conf']{
    source => undef,
    ensure => absent
  }
}

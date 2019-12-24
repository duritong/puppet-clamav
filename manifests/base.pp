# setup clamav
class clamav::base {
  package{'clamav':
    ensure => installed,
  } -> file_line{'enable_freshclam':
    line  => '#Example',
    match => '^(#)?Example',
    path  => '/etc/freshclam.conf',
  } ~> exec{'init-clamav-db':
    command     => 'freshclam',
    refreshonly => true,
    subscribe   => Package['clamav'],
  }
}

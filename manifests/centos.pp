# centos specific changes
class clamav::centos inherits clamav::base {
  if versioncmp($::operatingsystemmajrelease,'6') > 0 {
    package{'clamav-update':
      ensure => present,
      before => File_line['enable_freshclam'],
    } -> file_line{'enable_freshclam_update':
      line  => '#FRESHCLAM_DELAY=disabled-warn   # REMOVE ME',
      path  => '/etc/sysconfig/freshclam',
      match => '^(#)?FRESHCLAM_DELAY=disabled-warn',
    }
  }
}

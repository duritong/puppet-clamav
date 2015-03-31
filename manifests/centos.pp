# centos specific changes
class clamav::centos inherits clamav::base {
  if versioncmp($::operatingsystemmajrelease,'6') > 0 {
    package{'clamav-update':
      ensure => present,
      before => File_line['enable_freshclam'],
    }
  }
}

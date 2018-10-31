# centos specific changes
class clamav::centos inherits clamav::base {
  if versioncmp($::operatingsystemmajrelease,'6') > 0 {
    package{'clamav-update':
      ensure => present,
    } ~> exec{'/usr/bin/freshclam --quiet':
      refreshonly => true,
      before      => File_line['enable_freshclam'],
    }
    if str2bool($::selinux) {
      selboolean{
        'antivirus_use_jit':
          value      => 'on',
          persistent => true,
      }
    }
  }
}

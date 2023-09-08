# centos specific changes
class clamav::centos inherits clamav::base {
  package{'clamav-freshclam':
    ensure => present,
  } ~> exec{'/usr/bin/freshclam --quiet':
    refreshonly => true,
    before      => File_line['enable_freshclam'],
  }
  if versioncmp($facts['os']['release']['major'],'9') < 0 {
    Package['clamav-freshclam']{
      name => 'clamav-update'
    }
  }
  if str2bool($facts['selinux']) {
    selboolean{
      'antivirus_use_jit':
        value      => 'on',
        persistent => true,
    }
  }
}

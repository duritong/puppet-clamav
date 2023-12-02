# setup clamav
class clamav::base {
  package{['clamav','clamav-freshclam']:
    ensure => installed,
  } ~> exec{'init-clamav-db':
    command     => '/usr/bin/freshclam --quiet',
    refreshonly => true,
    before      => File_line['enable_freshclam'],
  } -> file_line{'enable_freshclam':
    line  => '#Example',
    match => '^(#)?Example',
    path  => '/etc/freshclam.conf',
  }

  if versioncmp($facts['os']['release']['major'],'9') < 0 {
    Package['clamav-freshclam']{
      name => 'clamav-update'
    }
  } else {
    File_line['enable_freshclam'] ~> service {
      'clamav-freshclam':
        ensure => running,
        enable => true,
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

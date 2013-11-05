# scan webhostings on our backup server for virii
# and inform the specific owner
class clamav::backup_webhosting_scan(
  $base          = '/data/backup_webhostings',
  $from          = 'root@example.com',
  $from_expanded = 'root',
  $to_domain     = 'security-scan.example.com',
  $template      = '/usr/local/backup_webhosting_scan/scan.template',
) {

  package{'clamav':
    ensure => present,
  }

  file{
    '/usr/local/backup_webhosting_scan':
      ensure  => directory,
      purge   => true,
      force   => true,
      recurse => true,
      require => Package['clamav'],
      owner   => root,
      group   => 0,
      mode    => '0400';
    '/usr/local/backup_webhosting_scan/scan':
      source  => 'puppet:///modules/clamscan/backup_webhosting_scan/scan',
      owner   => root,
      group   => 0,
      mode    => '0500';
    '/usr/local/backup_webhosting_scan/scan.config':
      content => template('clamscan/backup_webhosting_scan/scan.config.erb'),
      owner   => root,
      group   => 0,
      mode    => '0400';
    $template:
      source  => [
        'puppet:///modules/site_clamscan/backup_webhosting_scan/scan.template',
        'puppet:///modules/clamscan/backup_webhosting_scan/scan.template',
      ],
      owner   => root,
      group   => 0,
      mode    => '0400';
    '/etc/cron.weekly/backup_webhosting_scan':
      ensure  => link,
      target  => '/usr/local/backup_webhosting_scan/scan';
  }
}

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
      source  => 'puppet:///modules/clamav/backup_webhosting_scan/scan',
      owner   => root,
      group   => 0,
      mode    => '0500';
    '/usr/local/backup_webhosting_scan/scan.config':
      content => template('clamav/backup_webhosting_scan/scan.config.erb'),
      owner   => root,
      group   => 0,
      mode    => '0400';
    $template:
      source  => [
        'puppet:///modules/site_clamav/backup_webhosting_scan/scan.template',
        'puppet:///modules/clamav/backup_webhosting_scan/scan.template',
      ],
      owner   => root,
      group   => 0,
      mode    => '0400';
    '/etc/cron.d/backup_webhosting_scan':
      content => "0 5 * * 6 root /usr/local/backup_webhosting_scan/scan\n";
      owner   => root,
      group   => 0,
      mode    => '0400';
  }
}

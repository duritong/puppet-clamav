# gentoo specific things
class clamav::gentoo inherits clamav::base {
  Package['clamav']{
    category => 'app-antivirus',
  }
}

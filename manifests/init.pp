# manifests/init.pp - manage clamav stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# this module is part of a whole bunch of modules, please have a look at the exim module
class clamav {
  case $facts['os']['name'] {
    'Gentoo': { include clamav::gentoo }
    'CentOS': { include clamav::centos }
    default: { include clamav::base }
  }
}

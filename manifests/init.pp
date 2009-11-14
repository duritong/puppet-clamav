# modules/clamav/manifests/init.pp - manage clamav stuff
# Copyright (C) 2007 admin@immerda.ch
# GPLv3
# this module requires the amavisd-new module
# this module is part of a whole bunch of modules, please have a look at the exim module
#

class clamav {
    case $operatingsystem {
        gentoo: {include clamav::gentoo}
        default: {include clamav::base}
    }
}

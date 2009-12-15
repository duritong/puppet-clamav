class clamav::debian inherits clamav::base {
    package {"clamav-daemon":
	ensure => installed;
    }
    user { "clamav":
                ensure =>  present,
                groups => "amavis"  ,
                #require => Group["amavis"]  ,
        }
}

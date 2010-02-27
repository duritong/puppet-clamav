class clamav::debian inherits clamav::base {
  package {"clamav-daemon":
	  ensure => installed;
  }
  Service['clamd']{
    name => 'clamav-daemon',
    require +> Package['clamav-daemon']
  }
  user { "clamav":
    ensure =>  present,
    groups => "amavis"  ,
    #require => Group["amavis"],
  }
}

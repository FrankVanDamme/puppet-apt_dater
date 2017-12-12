define apt_dater::section ( 
    $sectname ,
) {
    if ( ! defined( Concat::Fragment[$sectname] ) ){
	concat::fragment { "$sectname": 
	    target  => "/root/.config/apt-dater/hosts.conf",
	    content => "\n[$sectname]\nHosts=",
	    order   => "${sectname}0",
	} 
    }
    Concat::Fragment <<| tag == "$sectname" |>>
}

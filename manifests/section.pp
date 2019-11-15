define apt_dater::section ( 
    $sectname ,
) {
    # fragments voor section header
    $fragname="${environment}_$sectname"

    if ( ! defined( Concat::Fragment[$fragname] ) ){
	concat::fragment { "$fragname": 
            target  => "/root/.config/apt-dater/hosts.conf",
            content => "\n[$sectname]\nHosts=",
            order   => "${sectname}0",
	} 
    }

    # fragments waar de hostname in staat
    # deze worden verzameld op de server

    Concat::Fragment <<| tag == "$sectname" and tag == "env_$environment" |>>
}

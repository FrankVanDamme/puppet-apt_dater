class apt_dater::server {
    $cnf_sys =  "/etc/apt-dater/apt-dater.xml"
    $hosts_conf_root = "/root/.config/apt-dater/hosts.conf"
    $hosts_xml_root = "/root/.config/apt-dater/xml.conf"

    package { "apt-dater": 
	ensure => present,
    }

    -> file { $cnf_sys:
        content => template("$module_name/apt-dater.xml.system.erb"),
    }

    Apt_dater::Section <<| |>>

    file { "/root/.config/apt-dater":
	ensure => directory,
    }

    concat { $hosts_conf_root: }

    -> exec { "/usr/lib/x86_64-linux-gnu/apt-dater/hosts2xml -i $hosts_conf_root -o $hosts_xml_root":
        refreshonly =>  true,
    }
}

class apt_dater::server {
    package { "apt-dater": 
	ensure => present,
    }

    Apt_dater::Section <<| |>>

    file { "/root/.config/apt-dater":
	ensure => directory,
    }

    concat { "/root/.config/apt-dater/hosts.conf": }
}

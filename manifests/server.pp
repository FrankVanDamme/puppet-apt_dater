class apt_dater::server {
    package { "apt-dater": 
	ensure => present,
    }

    Apt_dater::Section <<| |>>

    concat { "/root/.config/apt-dater/hosts.conf": }
}

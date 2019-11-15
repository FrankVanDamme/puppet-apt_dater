# Class: apt_dater
# ===========================
#
# Full description of class apt_dater here.
#
# Parameters
# ----------
#
# Document parameters here.
#
# * `sample parameter`
# Explanation of what this parameter affects and what it defaults to.
# e.g. "Specify one or more upstream ntp servers as an array."
#
# Variables
# ----------
#
# Here you should define a list of variables that this module would require.
#
# * `sample variable`
#  Explanation of how this variable affects the function of this class and if
#  it has a default. e.g. "The parameter enc_ntp_servers must be set by the
#  External Node Classifier as a comma separated list of hostnames." (Note,
#  global variables should be avoided in favor of class parameters as
#  of Puppet 2.6.)
#
# Examples
# --------
#
# @example
#    class { 'apt_dater':
#      servers => [ 'pool.ntp.org', 'ntp.local.company.com' ],
#    }
#
# Authors
# -------
#
# Author Name <author@domain.com>
#
# Copyright
# ---------
#
# Copyright 2017 Your name here, unless otherwise noted.
#

class apt_dater () {

    if ( $::osfamily == "Debian" ){

	package { "apt-dater-host":
	    ensure => present,
	}

    } elsif ( $::osfamily == "RedHat" ){

	file { "/usr/local/bin/apt-dater-host":
	    ensure         => present,
	    checksum       => "sha256",
	    mode           => "u+x",
	    checksum_value => "f564ccbd89d1deffac4828876131759e5f4e9430cc5b9d4b619b9fce23ed0f9a",
	    source         => "https://raw.githubusercontent.com/DE-IBH/apt-dater-host/7f477950bc2538ca309e3d5002b31021e0c694a9/yum/apt-dater-host",
	}

    } else {
	fail ("apt-dater: operating system not supported!")
    }

    $sectname = "$apptier-$role"
    $fragment_tag = "env_$environment-sect_$sectname"

    @@apt_dater::section { "$::fqdn": 
	sectname => "$sectname",
    }

    @@concat::fragment { "apt_dater_host_$::fqdn":
        target  => "/root/.config/apt-dater/hosts.conf",
        content => "$::fqdn;",
        tag    => [ "env_$environment", $sectname ],
        order   => "${sectname}1",
    }
}

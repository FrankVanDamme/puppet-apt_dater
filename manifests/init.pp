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

	$sectname = "$apptier-$role"
	
	@@apt_dater::section { "$::fqdn": 
	    sectname => "$sectname",
	}

	@@concat::fragment { "apt_dater_host_$::fqdn":
	    target  => "/root/.config/apt-dater/hosts.conf",
	    content => "$::fqdn;",
	    tag     => $sectname,
	    order   => "${sectname}1",
	}
    } else {
	info ("Operating system must run APT!")
    }
}

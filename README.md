puppet-module-arc
=================

Puppet Module to manage tcl-devel package, libtcl symlink and /etc/rndrelease.

This module requires that you have OpenAFS installed. It is intended to be used in cooperation with
 puppet-module-afs. It is needed for modulecmd to work properly on all platforms.

# Compatibility #

See metadata.json for compatibility information.

Other operating systems might be supported by specifying (!) parameters which defaults to undef or [].

# Version history #

Future releases will be documented in CHANGELOG.md.

Change log for older versions below:
* 2.0.0 2022-08-09
  * Update PDK to 2.5.0
  * Move OS specifc data into hiera
  * Add support for RedHat 8
  * Use ensure_packages() to avoid conflicts
  * Refactor unit tests to use rspec-puppet-facts
  * Various small refactors
  * Drop support for historical OS flavours of Ubuntu 12.04, SLED/SLES 10, RedHat 5
  * Drop support for all 32bit OS flavours
  * Drop support for Solaris, Scientific and OracleLinux
* 1.10.0 2020-10-16
  * Add support for Ubuntu 20.04
* 1.9.0 2020-02-12
  * Add support for Red Hat 8
* 1.8.0 2020-01-09
  * Add support for Suse 15
  * Remove ruby 1.8.7 support
* 1.7.1 2018-10-24 * Support Puppet 6.x
* 1.7.0 2018-10-19 * Add support for Ubuntu 18.04
* 1.6.1 2018-09-26 * Support Puppet 5.x
* 1.6.0 2017-08-02 * Add support for CentOS family
* 1.5.0 2017-06-28
  * Add support for Ubuntu 16
  * Enhance unless condition for locale-gen exec resource
  * Add tcl-dev for Ubuntu flavours
* 1.4.0 2017-02-20 Support Puppet 4.9 and Ruby 2.3.1
* 1.3.0 2016-02-24 Add possibility to manage arc console icon
* 1.2.2 2015-08-14 Drop unneeded 32bit support on RedHat 7
* 1.2.1 2015-07-31 Support for Puppet v4
* 1.2.0 2015-05-06 Add ability to unmanage rndrelease file
* 1.1.1 2015-03-24 Manage tcsh package as dependency
* 1.1.0 2015-02-24 Add Ubuntu support for 12.04/14.04
* 1.0.1 2015-02-16
  * Prepare for Puppet v4
  * deprecate type() as preparation for Puppet v4
  * Requires stdlib >= 4.2 now
* 1.0.0 2014-11-13 Initial release

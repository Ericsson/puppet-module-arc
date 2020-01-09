puppet-module-arc
=================

Puppet Module to manage tcl-devel package, libtcl symlink and /etc/rndrelease.

This module assumes that you have OpenAFS installed. It is ment to be used in cooperation with
puppet-module-afs. It is needed for modulecmd to work properly on all platforms.

# Compatability #

This module has been tested to work on the following systems with Puppet v3
(with and without the future parser) and ruby versions 1.9.3, 2.0.0 and 2.1.9,
Puppet v4, Puppet v5 and Puppet v6.

This module provides OS default values for these OSfamilies:

 * RedHat/CentOS 5/6/7
 * Solaris 9/10
 * Suse 10/11/12/15
 * Ubuntu 12.04/14.04/16.04/18.04

For other OSfamilies support, please specify all (!) parameters which defaults to 'USE_DEFAULTS'.


# Version history #
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


# Parameters #

create_rndrelease
=================
Boolean to trigger creation of /etc/rndrelease file.
If set to false /etc/rndrelease will be deleted.

- *Default*: true


manage_rndrelease
=================
Boolean to trigger management of /etc/rndrelease file.
If set to false /etc/rndrelease will not be managed.

- *Default*: true


create_symlink
==============
Boolean to trigger creation of libtcl symlink.

- *Default*: true


install_package
===============
Boolean to trigger installation of packages.

- *Default*: true


package_adminfile
-----------------
Solaris specific: string with adminfile.

- *Default*: undef


packages
============
Array with package names to be installed.

- *Default*: 'USE_DEFAULTS', based on OS platform


package_provider
----------------
Solaris specific: string with package provider.

- *Default*: undef


package_source
--------------
Solaris specific: string with package source.

- *Default*: undef


rndrelease_version
==================
String containing the content for /etc/rndrelease.
If set to undef /etc/rndrelease will be deleted.

- *Default*: 'USE_DEFAULTS', based on OS platform


symlink_target
==============
Absolute path to the target of the libtcl symlink.

- *Default*: 'USE_DEFAULTS', based on OS platform


manage_arc_console_icon
==============
Boolean to trigger if arc_console.desktop should be managed.

- *Default*: false


arc_console_icon
==============
Boolean to trigger creation (true) or deletion (false) of arc_console.desktop for the the arc_console.

- *Default*: false


Hiera example:
<pre>
arc::create_rndrelease: true
arc::create_symlink:    true
arc::install_package:   true
</pre>

puppet-module-arc
=================

Puppet Module to manage tcl-devel package, libtcl symlink and /etc/rndrelease.

This module assumes that you have OpenAFS installed. It is ment to be used in cooperation with puppet-module-afs. It is needed for modulecmd to work properly on all platforms.


# Compatability #

This module provides OS default values for these OSfamilies:

 * RedHat 5/6/7
 * Solaris 9/10
 * Suse 10/11/12

For other OSfamilies support, please specify all (!) parameters which defaults to 'USE_DEFAULTS'.


# Version history #
- 1.0.1 2015-02-16 deprecate type() as preparation for Puppet v4. Requires stdlib >= 4.2 now
- 1.0.0 2014-11-13 initial release


# Parameters #

create_rndrelease
=================
Boolean to trigger creation of /etc/rndrelease file.
If set to false /etc/rndrelease will be deleted.

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


Hiera example:
<pre>
arc::create_rndrelease: true
arc::create_symlink:    true
arc::install_package:   true
</pre>

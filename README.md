puppet-module-arc
=================

Puppet Module to manage tcl-devel package, libtcl symlink and /etc/rndrelease.

This module assumes that you have OpenAFS installed. It is ment to be used in cooperation with puppet-module-afs. It is needed for modulecmd to work properly on all platforms.


# Compatability #

This module provides OS default values for these OSfamilies:

 * RedHat
 * Suse
 * Solaris

For other OSfamilies support, please specify all (!) parameters which defaults to 'USE_DEFAULTS'.


# Parameters #

create_rndrelease
=================
Boolean to trigger creation of /etc/rndrelease file.

- *Default*: true


create_symlink
==============
Boolean to trigger creation of libtcl symlink.

- *Default*: true


install_package
===============
Boolean to trigger package installation for tcl-devel.

- *Default*: true


package_name
============
String with package name of tcl-devel.

- *Default*: 'USE_DEFAULTS', based on OS platform


rndrelease_version
==================
String containing the content for /etc/rndrelease.

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

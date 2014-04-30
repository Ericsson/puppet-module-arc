puppet-module-template
======================

Puppet Module to act as template

The module does not make meanfull things, it is only a template you know ?

# Compatability #

This module provides OS default values for these OSfamilies:

 * RedHat
 * Suse
 * Solaris

For other OSfamilies support, please specify all parameters which defaults to 'USE_DEFAULTS'.


# Parameters #

var1
----
String with template content.

- *Default*: 'USE_DEFAULTS', based on OS platform


var2
----
Boolean with template content.

- *Default*: 'USE_DEFAULTS', based on OS platform


var3
----
Silly value that will always fail because of multiple checks for different types.
Use that to test the different given examples.

- *Default*: '242'


Hiera example:
<pre>
template::var1: 'string are allowed here'
template::var2: true
template::var3: 'play with me'
</pre>

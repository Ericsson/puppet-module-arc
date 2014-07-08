# == Class: arc
#
# Manages tcl-devel package, libtcl symlink and /etc/rndrelease.

class arc (
  $create_rndrelease  = true,
  $create_symlink     = true,
  $install_package    = true,
  $package_adminfile  = undef,
  $package_name       = 'USE_DEFAULTS',
  $package_provider   = undef,
  $package_source     = undef,
  $rndrelease_version = 'USE_DEFAULTS',
  $symlink_target     = 'USE_DEFAULTS',
) {

  # <define os default values>
  # Set $os_defaults_missing to true for unspecified osfamilies

  case "${::operatingsystem}-${::operatingsystemrelease}" {
    /^RedHat-5/: {
      $package_name_default       = 'tcl-devel.i386'
      $rndrelease_version_default = 'LMWP 2.3'
      $symlink_target_default     = '/usr/lib/libtcl8.4.so'
    }
    /^RedHat-6/: {
      $package_name_default       = 'tcl-devel.i686'
      $rndrelease_version_default = 'LMWP 2.3'
      $symlink_target_default     = '/usr/lib/libtcl8.5.so'
    }
    /^SLED-10|SLES-10/: {
      if $::architecture == 'x86_64' {
        $package_name_default     = 'tcl-32bit'
      } else {
        $package_name_default     = 'tcl'
      }
      $rndrelease_version_default = 'LMWP 2.3'
      $symlink_target_default     = '/usr/lib/libtcl8.4.so'
    }
    /^SLED-11|SLES-11/: {
      if $::architecture == 'x86_64' {
        $package_name_default     = 'tcl-32bit'
      } else {
        $package_name_default     = 'tcl'
      }
      $rndrelease_version_default = 'LMWP 3.1'
      $symlink_target_default     = '/usr/lib/libtcl8.5.so'
    }
    /^Solaris/: {
      $package_name_default       = undef
      $rndrelease_version_default = "UMWP 3.3 Solaris ${::operatingsystemrelease} SPARC"
      $symlink_target_default     = undef
    }
    default: {
      $os_defaults_missing = true
    }
  }
  # </define os default values>


  # <USE_DEFAULTS vs OS defaults>
  # Check if 'USE_DEFAULTS' is used anywhere without having OS default value
  if (
    ($package_name       == 'USE_DEFAULTS') or
    ($rndrelease_version == 'USE_DEFAULTS') or
    ($symlink_target     == 'USE_DEFAULTS')
  ) and $os_defaults_missing == true {
      fail("Sorry, I don't know default values for ${::operatingsystem}-${::operatingsystemrelease} yet :( Please provide specific values to the arc module.")
  }
  # </USE_DEFAULTS vs OS defaults>


  # <assign variables>
  # Change 'USE_DEFAULTS' to OS specific default values
  # Convert strings with booleans to real boolean, if needed

  if type($create_rndrelease) == 'boolean' {
    $create_rndrelease_real = $create_rndrelease
  } else {
    $create_rndrelease_real = str2bool($create_rndrelease)
  }

  if type($create_symlink) == 'boolean' {
    $create_symlink_real = $create_symlink
  } else {
    $create_symlink_real = str2bool($create_symlink)
  }

  if type($install_package) == 'boolean' {
    $install_package_real = $install_package
  } else {
    $install_package_real = str2bool($install_package)
  }

  $package_adminfile_real = $package_adminfile

  $package_name_real = $package_name ? {
    'USE_DEFAULTS' => $package_name_default,
    default        => $package_name
  }

  $package_provider_real = $package_provider
  $package_source_real   = $package_source

  $rndrelease_version_real = $rndrelease_version ? {
    'USE_DEFAULTS' => $rndrelease_version_default,
    default        => $rndrelease_version
  }

  $symlink_target_real = $symlink_target ? {
    'USE_DEFAULTS' => $symlink_target_default,
    default        => $symlink_target
  }

  # </assign variables>


  # <validating variables>

  validate_bool($create_rndrelease_real)
  validate_bool($create_symlink_real)
  validate_bool($install_package_real)

  if $package_adminfile_real != undef {
    validate_string($package_adminfile_real)
  }

  if $package_name_real != undef {
    validate_string($package_name_real)
  }

  if $package_source_real != undef {
    validate_string($package_source_real)
  }

  validate_string($rndrelease_version_real)

  if $symlink_target_real != undef {
    validate_absolute_path($symlink_target_real)
  }

  # </validating variables>


  # <Do Stuff>

  if $create_rndrelease_real == true {
    file { 'arc_rndrelease':
      ensure  => present,
      path    => '/etc/rndrelease',
      mode    => '0644',
      content => "${rndrelease_version_real}\n",
    }
  }

  if $create_symlink_real == true {
    file { 'arc_symlink':
      ensure  => link,
      path    => '/usr/lib/libtcl.so.0',
      target  => $symlink_target_real,
    }
  }

  if $package_adminfile_real != undef {
    Package {
      adminfile => $package_adminfile_real,
    }
  }

  if $package_provider_real != undef {
    Package {
      provider => $package_provider_real,
    }
  }

  if $package_source_real != undef {
    Package {
      source => $package_source_real,
    }
  }

  if $install_package_real == true and $package_name_real != undef {
    package { $package_name_real:
      ensure => present,
    }
  }

  # </Stuff done>

}

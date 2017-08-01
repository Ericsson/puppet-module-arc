# == Class: arc
#
# Manages tcl-devel package, libtcl symlink and /etc/rndrelease.

class arc (
  $manage_rndrelease       = true,
  $create_rndrelease       = true,
  $create_symlink          = true,
  $install_package         = true,
  $package_adminfile       = undef,
  $packages                = 'USE_DEFAULTS',
  $package_provider        = undef,
  $package_source          = undef,
  $rndrelease_version      = 'USE_DEFAULTS',
  $symlink_target          = 'USE_DEFAULTS',
  $manage_arc_console_icon = false,
  $arc_console_icon        = false,
) {

  # <define os default values>
  # Set $os_defaults_missing to true for unspecified osfamilies

  case "${::operatingsystem}-${::operatingsystemrelease}" {
    /^(RedHat|CentOS)-5/: {
      $os_defaults_missing        = false
      $packages_default           = [ 'libXmu.i386', 'tcl-devel.i386', 'tcsh'  ]
      $rndrelease_version_default = undef
      $symlink_target_default     = '/usr/lib/libtcl8.4.so'
    }
    /^(RedHat|CentOS)-6/: {
      $os_defaults_missing        = false
      $packages_default           = [ 'libXmu.i686', 'tcl-devel.i686', 'tcsh' ]
      $rndrelease_version_default = undef
      $symlink_target_default     = '/usr/lib/libtcl8.5.so'
    }
    /^(RedHat|CentOS)-7/: {
      $os_defaults_missing        = false
      $packages_default           = [ 'tcsh', 'libX11.i686' ]
      $rndrelease_version_default = undef
      $symlink_target_default     = undef
    }
    /^(SLED-10|SLES-10)/: {
      $os_defaults_missing        = false
      $packages_default           = $::architecture ? {
        'x86_64' => [ 'tcl-32bit', 'tcsh' ],
        default  => [ 'tcl', 'tcsh' ],
      }
      $rndrelease_version_default = $::operatingsystemrelease ? {
        '10.0'  => 'LMWP 2.0',
        '10.1'  => 'LMWP 2.1',
        '10.2'  => 'LMWP 2.2',
        '10.3'  => 'LMWP 2.3',
        '10.4'  => 'LMWP 2.4',
        default => undef,
      }
      $symlink_target_default     = '/usr/lib/libtcl8.4.so'
    }
    /^(SLED-11|SLES-11)/: {
      $os_defaults_missing        = false
      $packages_default           = $::architecture ? {
        'x86_64' => [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        default  => [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
      }
      $rndrelease_version_default = $::operatingsystemrelease ? {
        '11.0'  => 'LMWP 3.0',
        '11.1'  => 'LMWP 3.1',
        '11.2'  => 'LMWP 3.2',
        '11.3'  => 'LMWP 3.3',
        default => undef,
      }
      $symlink_target_default     = '/usr/lib/libtcl8.5.so'
    }
    /^(SLED-12|SLES-12)/: {
      $os_defaults_missing        = false
      $packages_default           = [ 'libXmu6-32bit', 'tcl-32bit', 'tcsh' ]
      $rndrelease_version_default = undef
      $symlink_target_default     = '/usr/lib/libtcl8.6.so'
    }
    /^Solaris/: {
      $os_defaults_missing        = false
      $packages_default           = undef
      $rndrelease_version_default = $::kernelrelease ? {
        '5.9'  => 'UMWP 2.0',
        '5.10' => 'UMWP 3.0',
        default => undef,
      }
      $symlink_target_default     = undef
    }
    /^(Ubuntu-12|Ubuntu-14|Ubuntu-16)/: {
      $os_defaults_missing        = false
      $packages_default           = [ 'tcsh', 'libx11-6:i386', 'libc6:i386', 'tcl-dev' ]
      $rndrelease_version_default = undef
      $symlink_target_default     = undef
    }
    default: {
      $os_defaults_missing = true
    }
  }
  # </define os default values>

  # <convert stringified booleans>
  if is_bool($create_rndrelease) == true {
    $create_rndrelease_real = $create_rndrelease
  } else {
    $create_rndrelease_real = str2bool($create_rndrelease)
  }

  if is_bool($manage_rndrelease) == true {
    $manage_rndrelease_real = $manage_rndrelease
  } else {
    $manage_rndrelease_real = str2bool($manage_rndrelease)
  }

  if is_bool($create_symlink) == true {
    $create_symlink_real = $create_symlink
  } else {
    $create_symlink_real = str2bool($create_symlink)
  }

  if is_bool($install_package) == true {
    $install_package_real = $install_package
  } else {
    $install_package_real = str2bool($install_package)
  }

  if is_bool($arc_console_icon) == true {
    $arc_console_icon_real = $arc_console_icon
  } else {
    $arc_console_icon_real = str2bool($arc_console_icon)
  }

  if is_bool($manage_arc_console_icon) == true {
    $manage_arc_console_icon_real = $manage_arc_console_icon
  } else {
    $manage_arc_console_icon_real = str2bool($manage_arc_console_icon)
  }
  # </convert stringified booleans>

  # <USE_DEFAULTS vs OS defaults>
  # Check if 'USE_DEFAULTS' is used anywhere without having OS default value
  if (
    ($packages           == 'USE_DEFAULTS' and $install_package_real   != true) or
    ($rndrelease_version == 'USE_DEFAULTS' and $create_rndrelease_real != true) or
    ($symlink_target     == 'USE_DEFAULTS' and $create_symlink_real    != true)
  ) and $os_defaults_missing == true {
      fail("Sorry, I don't know default values for ${::operatingsystem}-${::operatingsystemrelease} yet :( Please provide specific values to the arc module.")
  }
  # </USE_DEFAULTS vs OS defaults>

  # <assign variables>
  # Change 'USE_DEFAULTS' to OS specific default values
  # Convert strings with booleans to real boolean, if needed

  $package_adminfile_real = $package_adminfile

  $packages_real = $packages ? {
    'USE_DEFAULTS' => $packages_default,
    default        => $packages
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
  validate_bool($manage_rndrelease_real)
  validate_bool($create_symlink_real)
  validate_bool($install_package_real)
  validate_bool($arc_console_icon_real)
  validate_bool($manage_arc_console_icon_real)

  if $package_adminfile_real != undef {
    validate_string($package_adminfile_real)
  }

  if $packages_real != undef {
    validate_array($packages_real)
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

  if ($create_rndrelease_real == false or $rndrelease_version_real == undef) {
    $rndrelease_ensure = 'absent'
  } else {
    $rndrelease_ensure = 'present'
  }

  if $manage_rndrelease_real == true {
    file { 'arc_rndrelease':
      ensure  => $rndrelease_ensure,
      path    => '/etc/rndrelease',
      mode    => '0644',
      content => "${rndrelease_version_real}\n",
    }
  }

  if $::operatingsystem == 'Ubuntu' {
    file { 'awk_symlink':
      ensure => link,
      path   => '/bin/awk',
      target => '/usr/bin/awk',
    }

    exec { 'locale-gen':
      command => '/usr/sbin/locale-gen en_US',
      unless  => '/usr/bin/locale -a |grep -q ^en_US.iso88591$',
      path    => '/bin:/usr/bin:/sbin:/usr/sbin',
    }
  }

  if ($create_symlink_real == true and $symlink_target_real != undef) {
    file { 'arc_symlink':
      ensure => link,
      path   => '/usr/lib/libtcl.so.0',
      target => $symlink_target_real,
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

  if $install_package_real == true and $packages_real != undef {
    package { $packages_real:
      ensure => present,
    }
  }

  if $manage_arc_console_icon_real == true {
    if $arc_console_icon_real == true {
      file { 'arc_console.desktop':
        ensure => file,
        path   => '/usr/share/applications/arc_console.desktop',
        owner  => 'root',
        group  => 'root',
        mode   => '0644',
        source => 'puppet:///modules/arc/arc_console.desktop', # lint:ignore:fileserver
      }
    } else {
      file { 'arc_console.desktop':
        ensure => absent,
        path   => '/usr/share/applications/arc_console.desktop',
      }
    }
  }
  # </Stuff done>

}

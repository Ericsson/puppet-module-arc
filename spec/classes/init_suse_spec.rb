# For SLED/SLES we need individual tests for each affected minor release and
# for both CPU architectures. Since this is not possible with rspec-puppet-facts,
# explicit tests are necessary here. The parameters $rndrelease_version (release)
# & $packages (architecture) are affected.

require 'spec_helper'
describe 'arc' do
  platforms = {
    'SLED-10.0 i386' => {
      package_name_default: [ 'tcl', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.0',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '10.0',
          major: '10',
        }
      }
    },
    'SLES-10.0 i386' => {
      package_name_default: [ 'tcl', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.0',
      os: {
        architecture: 'i386',
        name: 'SLES',
        release: {
          full: '10.0',
          major: '10',
        }
      }
    },
    'SLED-10.0 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.0',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '10.0',
          major: '10',
        }
      }
    },
    'SLES-10.0 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.0',
      os: {
        architecture: 'x86_64',
        name: 'SLES',
        release: {
          full: '10.0',
          major: '10',
        }
      }
    },
    'SLED-10.1 i386' => {
      package_name_default: [ 'tcl', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.1',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '10.1',
          major: '10',
        }
      }
    },
    'SLED-10.1 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.1',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '10.1',
          major: '10',
        }
      }
    },
    'SLED-10.2 i386' => {
      package_name_default: [ 'tcl', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.2',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '10.2',
          major: '10',
        }
      }
    },
    'SLED-10.2 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.2',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '10.2',
          major: '10',
        }
      }
    },
    'SLED-10.3 i386' => {
      package_name_default: [ 'tcl', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.3',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '10.3',
          major: '10',
        }
      }
    },
    'SLED-10.3 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.3',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '10.3',
          major: '10',
        }
      }
    },
    'SLED-10.4 i386' => {
      package_name_default: [ 'tcl', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.4',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '10.4',
          major: '10',
        }
      }
    },
    'SLED-10.4 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh' ],
      rndrelease_version_default: 'LMWP 2.4',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '10.4',
          major: '10',
        }
      }
    },
    'SLED-11.0 i386' => {
      package_name_default: [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
      rndrelease_version_default: 'LMWP 3.0',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '11.0',
          major: '11',
        }
      }
    },
    'SLES-11.0 i386' => {
      package_name_default: [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
      rndrelease_version_default: 'LMWP 3.0',
      os: {
        architecture: 'i386',
        name: 'SLES',
        release: {
          full: '11.0',
          major: '11',
        }
      }
    },
    'SLED-11.0 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
      rndrelease_version_default: 'LMWP 3.0',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '11.0',
          major: '11',
        }
      }
    },
    'SLES-11.0 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
      rndrelease_version_default: 'LMWP 3.0',
      os: {
        architecture: 'x86_64',
        name: 'SLES',
        release: {
          full: '11.0',
          major: '11',
        }
      }
    },
    'SLED-11.1 i386' => {
      package_name_default: [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
      rndrelease_version_default: 'LMWP 3.1',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '11.1',
          major: '11',
        }
      }
    },
    'SLED-11.1 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
      rndrelease_version_default: 'LMWP 3.1',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '11.1',
          major: '11',
        }
      }
    },
    'SLED-11.2 i386' => {
      package_name_default: [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
      rndrelease_version_default: 'LMWP 3.2',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '11.2',
          major: '11',
        }
      }
    },
    'SLED-11.2 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
      rndrelease_version_default: 'LMWP 3.2',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '11.2',
          major: '11',
        }
      }
    },
    'SLED-11.3 i386' => {
      package_name_default: [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
      rndrelease_version_default: 'LMWP 3.3',
      os: {
        architecture: 'i386',
        name: 'SLED',
        release: {
          full: '11.3',
          major: '11',
        }
      }
    },
    'SLED-11.3 x86_64' => {
      package_name_default: [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
      rndrelease_version_default: 'LMWP 3.3',
      os: {
        architecture: 'x86_64',
        name: 'SLED',
        release: {
          full: '11.3',
          major: '11',
        }
      }
    },
  }

  describe 'with default values for parameters' do
    platforms.sort.each do |_k, v|
      context "where [os][name] is <#{v[:os][:name]}-#{v[:os][:release][:full]}> on <#{v[:os][:architecture]}>" do
        let :facts do
          {
            os: {
              architecture:         v[:os][:architecture],
              name:                 v[:os][:name],
              release: {
                full:               v[:os][:release][:full],
                major:              v[:os][:release][:major],
              }
            }
          }
        end

        # file { 'arc_rndrelease' :}
        it {
          is_expected.to contain_file('arc_rndrelease').with(
            {
              'content' => "#{v[:rndrelease_version_default]}\n",
            },
          )
        }

        # package { '$packages_real': }
        v[:package_name_default]&.each do |package|
          it { is_expected.to contain_package(package).with_ensure('present') }
        end
      end
    end
  end
end

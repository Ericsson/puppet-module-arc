require 'spec_helper'
describe 'arc' do
  let :facts do
    {
      os: {
        name: 'RedHat',
        release: {
          full: '7',
        }
      }
    }
  end

  platforms = {
    'RedHat-5 x86_64' =>
      {
        package_name_default:       [ 'libXmu.i386', 'tcl-devel.i386', 'tcsh' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'RedHat',
          release: {
            full: '5.0',
          }
        }
      },
    'RedHat-6 x86_64' =>
      {
        package_name_default:       [ 'libXmu.i686', 'tcl-devel.i686', 'tcsh' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'RedHat',
          release: {
            full: '6.0',
          }
        }
      },
    'RedHat-7 x86_64' =>
      {
        package_name_default:       [ 'tcsh', 'libX11.i686' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'RedHat',
          release: {
            full: '7.0',
          }
        }
      },
    'RedHat-8 x86_64' =>
      {
        package_name_default:       [ 'tcsh', 'libX11.i686', 'libxcrypt.i686', 'libnsl.i686' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'RedHat',
          release: {
            full: '8.0',
          }
        }
      },
    'CentOS-5 x86_64' =>
      {
        package_name_default:       [ 'libXmu.i386', 'tcl-devel.i386', 'tcsh' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'CentOS',
          release: {
            full: '5.0',
          }
        }
      },
    'CentOS-6 x86_64' =>
      {
        package_name_default:       [ 'libXmu.i686', 'tcl-devel.i686', 'tcsh' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'CentOS',
          release: {
            full: '6.0',
          }
        }
      },
    'CentOS-7 x86_64' =>
      {
        package_name_default:       [ 'tcsh', 'libX11.i686' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'CentOS',
          release: {
            full: '7.0',
          }
        }
      },
    'CentOS-8 x86_64' =>
      {
        package_name_default:       [ 'tcsh', 'libX11.i686', 'libxcrypt.i686', 'libnsl.i686' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'CentOS',
          release: {
            full: '8.0',
          }
        }
      },
    'SLED-10.0 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.0',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '10.0',
          }
        }
      },
    'SLES-10.0 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.0',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'i386',
          name: 'SLES',
          release: {
            full: '10.0',
          }
        }
      },
    'SLED-10.0 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.0',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '10.0',
          }
        }
      },
    'SLES-10.0 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.0',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'SLES',
          release: {
            full: '10.0',
          }
        }
      },
    'SLED-10.1 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.1',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '10.1',
          }
        }
      },
    'SLED-10.1 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.1',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '10.1',
          }
        }
      },
    'SLED-10.2 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.2',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '10.2',
          }
        }
      },
    'SLED-10.2 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.2',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '10.2',
          }
        }
      },
    'SLED-10.3 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.3',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '10.3',
          }
        }
      },
    'SLED-10.3 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.3',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '10.3',
          }
        }
      },
    'SLED-10.4 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.4',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '10.4',
          }
        }
      },
    'SLED-10.4 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh' ],
        rndrelease_version_default: 'LMWP 2.4',
        symlink_target_default:     '/usr/lib/libtcl8.4.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '10.4',
          }
        }
      },
    'SLED-11.0 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
        rndrelease_version_default: 'LMWP 3.0',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '11.0',
          }
        }
      },
    'SLES-11.0 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
        rndrelease_version_default: 'LMWP 3.0',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'i386',
          name: 'SLES',
          release: {
            full: '11.0',
          }
        }
      },
    'SLED-11.0 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        rndrelease_version_default: 'LMWP 3.0',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '11.0',
          }
        }
      },
    'SLES-11.0 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        rndrelease_version_default: 'LMWP 3.0',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'SLES',
          release: {
            full: '11.0',
          }
        }
      },
    'SLED-11.1 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
        rndrelease_version_default: 'LMWP 3.1',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '11.1',
          }
        }
      },
    'SLED-11.1 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        rndrelease_version_default: 'LMWP 3.1',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '11.1',
          }
        }
      },
    'SLED-11.2 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
        rndrelease_version_default: 'LMWP 3.2',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '11.2',
          }
        }
      },
    'SLED-11.2 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        rndrelease_version_default: 'LMWP 3.2',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '11.2',
          }
        }
      },
    'SLED-11.3 i386' =>
      {
        package_name_default:       [ 'tcl', 'tcsh', 'xorg-x11-libXmu' ],
        rndrelease_version_default: 'LMWP 3.3',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'i386',
          name: 'SLED',
          release: {
            full: '11.3',
          }
        }
      },
    'SLED-11.3 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        rndrelease_version_default: 'LMWP 3.3',
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '11.3',
          }
        }
      },
    'SLED-11.4 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.5.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '11.4',
          }
        }
      },
      'SLES-12.0 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'libXmu6-32bit' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.6.so',
        os: {
          architecture: 'x86_64',
          name: 'SLES',
          release: {
            full: '12.0',
          }
        }
      },
      'SLED-12.0 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'libXmu6-32bit' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.6.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '12.0',
          }
        }
      },
      'SLES-15.1 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'libXmu6-32bit' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.6.so',
        os: {
          architecture: 'x86_64',
          name: 'SLES',
          release: {
            full: '15.1',
          }
        }
      },
      'SLED-15.1 x86_64' =>
      {
        package_name_default:       [ 'tcl-32bit', 'tcsh', 'libXmu6-32bit' ],
        rndrelease_version_default: nil,
        symlink_target_default:     '/usr/lib/libtcl8.6.so',
        os: {
          architecture: 'x86_64',
          name: 'SLED',
          release: {
            full: '15.1',
          }
        }
      },
    'Ubuntu-12.04 x86_64' =>
      {
        package_name_default:       [ 'libx11-6:i386', 'libc6:i386', 'tcsh', 'tcl-dev' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'Ubuntu',
          release: {
            full: '12.04',
          }
        }
      },
    'Ubuntu-14.04 x86_64' =>
      {
        package_name_default:       [ 'libx11-6:i386', 'libc6:i386', 'tcsh', 'tcl-dev' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'Ubuntu',
          release: {
            full: '14.04',
          }
        }
      },
    'Ubuntu-16.04 x86_64' =>
      {
        package_name_default:       [ 'libx11-6:i386', 'libc6:i386', 'tcsh', 'tcl-dev' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'Ubuntu',
          release: {
            full: '16.04',
          }
        }
      },
    'Ubuntu-18.04 x86_64' =>
      {
        package_name_default:       [ 'libx11-6:i386', 'libc6:i386', 'tcsh', 'tcl-dev' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'Ubuntu',
          release: {
            full: '18.04',
          }
        }
      },
    'Ubuntu-20.04 x86_64' =>
      {
        package_name_default:       [ 'libx11-6:i386', 'libc6:i386', 'tcsh', 'tcl-dev' ],
        rndrelease_version_default: nil,
        symlink_target_default:     nil,
        os: {
          architecture: 'x86_64',
          name: 'Ubuntu',
          release: {
            full: '20.04',
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
              }
            }
          }
        end

        it { is_expected.to compile.with_all_deps }

        # file { 'arc_rndrelease' :}
        if v[:rndrelease_version_default].nil?
          it {
            is_expected.to contain_file('arc_rndrelease').with(
              {
                'ensure'  => 'absent',
                'path'    => '/etc/rndrelease',
              },
            )
          }
        else
          it {
            is_expected.to contain_file('arc_rndrelease').with(
              {
                'ensure'  => 'present',
                'path'    => '/etc/rndrelease',
                'mode'    => '0644',
                'content' => "#{v[:rndrelease_version_default]}\n",
              },
            )
          }
        end

        # file { 'arc_symlink' :}
        if v[:symlink_target_default].nil?
          it { is_expected.not_to contain_file('arc_symlink') }
        else
          it {
            is_expected.to contain_file('arc_symlink').with(
              {
                'ensure' => 'link',
                'path'   => '/usr/lib/libtcl.so.0',
                'target' => v[:symlink_target_default],
              },
            )
          }
        end

        # Ubuntu specific special specialities
        if v[:os][:name] == 'Ubuntu'
          if v[:os][:release][:full].match?(%r{^(10|12|14|16|18)})
            it {
              is_expected.to contain_file('awk_symlink').with(
                {
                  'ensure' => 'link',
                  'path'   => '/bin/awk',
                  'target' => '/usr/bin/awk',
                },
              )
            }
          end

          it {
            is_expected.to contain_exec('locale-gen').with(
              {
                'command' => '/usr/sbin/locale-gen en_US',
                'unless'  => '/usr/bin/locale -a |grep -q ^en_US.iso88591$',
                'path'    => '/bin:/usr/bin:/sbin:/usr/sbin',
              },
            )
          }
        else
          it { is_expected.not_to contain_file('awk_symlink') }
          it { is_expected.not_to contain_exec('locale-gen') }
        end

        # package { '$packages_real': }
        v[:package_name_default]&.each do |package|
          it { is_expected.to contain_package(package).with_ensure('present') }
        end
      end
    end
  end

  context 'with create_rndrelease set to false' do
    let(:params) { { create_rndrelease: false } }

    it {
      is_expected.to contain_file('arc_rndrelease').with(
        {
          'ensure' => 'absent',
          'path'   => '/etc/rndrelease',
        },
      )
    }
  end

  context 'with manage_arc_console_icon set to true' do
    context 'when arc_console_icon is set to true' do
      let :params do
        {
          manage_arc_console_icon: true,
          arc_console_icon:        true,
        }
      end

      it {
        is_expected.to contain_file('arc_console.desktop').with(
          {
            'ensure' => 'file',
            'path'   => '/usr/share/applications/arc_console.desktop',
            'mode'   => '0644',
            'owner'  => 'root',
            'group'  => 'root',
            'source' => 'puppet:///modules/arc/arc_console.desktop',
          },
        )
      }
    end

    context 'when arc_console_icon is set to false' do
      let :params do
        {
          manage_arc_console_icon: true,
          arc_console_icon:        false,
        }
      end

      it {
        is_expected.to contain_file('arc_console.desktop').with(
          {
            'ensure' => 'absent',
            'path'   => '/usr/share/applications/arc_console.desktop',
          },
        )
      }
    end
  end

  context 'with manage_arc_console_icon set to false' do
    [true, false].each do |value|
      context "when arc_console_icon is set to #{value}" do
        let :params do
          {
            manage_arc_console_icon: false,
            arc_console_icon:        value,
          }
        end

        it { is_expected.not_to contain_file('arc_console.desktop') }
      end
    end
  end

  context 'with manage_rndrelease set to false' do
    let(:params) { { manage_rndrelease: false } }

    it { is_expected.not_to contain_file('arc_rndrelease') }
  end

  context 'with create_symlink set to false' do
    let(:params) { { create_symlink: false } }

    it { is_expected.not_to contain_file('arc_symlink') }
  end

  context 'with install_package set to false' do
    let(:params) { { install_package: false } }

    it { is_expected.not_to contain_package('tcl-devel.i386') }
    it { is_expected.not_to contain_package('libXmu.i386') }
  end

  describe 'variable type and content validations' do
    # set needed custom facts and variables
    let(:facts) do
      {
        operatingsystem:        'RedHat',
        operatingsystemrelease: '7',
        os: {
          name: 'RedHat',
          release: {
            full: '7.0',
          }
        }
      }
    end
    let(:mandatory_params) do
      {
        #:param => 'value',
      }
    end

    validations = {
      'absolute_path' => {
        name:    ['symlink_target'],
        valid:   ['/absolute/filepath', '/absolute/directory/'],
        invalid: [['/array', '/with/paths'], '../invalid', 3, 2.42, ['array'], { 'ha' => 'sh' }, true, false, nil],
        message: 'expects a match for Variant\[Enum\[\'USE_DEFAULTS\'\], Stdlib::Absolutepath',
      },
      'array' => {
        name:    ['packages'],
        valid:   [['ar', 'ray']],
        invalid: ['string', { 'ha' => 'sh' }, 3, 2.42, true, false, nil],
        message: 'expects a match for Variant\[Enum\[\'USE_DEFAULTS\'\], Array\[String\[1\]',
      },
      'bool' => {
        name:    ['arc_console_icon', 'create_rndrelease', 'create_symlink', 'install_package', 'manage_arc_console_icon', 'manage_rndrelease'],
        valid:   [true, false],
        invalid: ['true', 'string', ['array'], { 'ha' => 'sh' }, 3, 2.42, nil],
        message: 'expects a Boolean value',
      },
    }

    validations.sort.each do |type, var|
      var[:name].each do |var_name|
        var[:params] = {} if var[:params].nil?
        var[:valid].each do |valid|
          context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
            let(:params) { [mandatory_params, var[:params], { "#{var_name}": valid, }].reduce(:merge) }

            it { is_expected.to compile }
          end
        end

        var[:invalid].each do |invalid|
          context "when #{var_name} (#{type}) is set to invalid #{invalid} (as #{invalid.class})" do
            let(:params) { [mandatory_params, var[:params], { "#{var_name}": invalid, }].reduce(:merge) }

            it 'fail' do
              expect { is_expected.to contain_class(:subject) }.to raise_error(Puppet::Error, %r{#{var[:message]}})
            end
          end
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'variable type and content validations'
end

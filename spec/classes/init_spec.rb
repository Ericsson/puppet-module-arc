require 'spec_helper'
describe 'arc' do

  platforms = {
    'RedHat-5 x86_64' =>
      { :operatingsystem            => 'RedHat',
        :operatingsystemrelease     => '5',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-devel.i386', 'libXmu.i386' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'RedHat-6 x86_64' =>
      { :operatingsystem            => 'RedHat',
        :operatingsystemrelease     => '6',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-devel.i686', 'libXmu.i686' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'RedHat-7 x86_64' =>
      { :operatingsystem            => 'RedHat',
        :operatingsystemrelease     => '7',
        :architecture               => 'x86_64',
        :package_name_default       => nil,
        :rndrelease_version_default => nil,
        :symlink_target_default     => '/usr/lib/libtcl.so.5',
      },
    'SLED-10.0 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.0',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl' ],
        :rndrelease_version_default => 'LMWP 2.0',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLES-10.0 i386' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '10.0',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl' ],
        :rndrelease_version_default => 'LMWP 2.0',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.0 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.0',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit' ],
        :rndrelease_version_default => 'LMWP 2.0',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLES-10.0 x86_64' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '10.0',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit' ],
        :rndrelease_version_default => 'LMWP 2.0',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.1 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.1',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl' ],
        :rndrelease_version_default => 'LMWP 2.1',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.1 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.1',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit' ],
        :rndrelease_version_default => 'LMWP 2.1',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.2 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.2',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl' ],
        :rndrelease_version_default => 'LMWP 2.2',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.2 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.2',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit' ],
        :rndrelease_version_default => 'LMWP 2.2',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.3 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.3',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl' ],
        :rndrelease_version_default => 'LMWP 2.3',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.3 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.3',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit' ],
        :rndrelease_version_default => 'LMWP 2.3',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.4 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.4',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl' ],
        :rndrelease_version_default => 'LMWP 2.4',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-10.4 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10.4',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit' ],
        :rndrelease_version_default => 'LMWP 2.4',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-11.0 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.0',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl', 'xorg-x11-libXmu' ],
        :rndrelease_version_default => 'LMWP 3.0',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLES-11.0 i386' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '11.0',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl', 'xorg-x11-libXmu' ],
        :rndrelease_version_default => 'LMWP 3.0',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.0 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.0',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'xorg-x11-libXmu-32bit' ],
        :rndrelease_version_default => 'LMWP 3.0',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLES-11.0 x86_64' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '11.0',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'xorg-x11-libXmu-32bit' ],
        :rndrelease_version_default => 'LMWP 3.0',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.1 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.1',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl', 'xorg-x11-libXmu' ],
        :rndrelease_version_default => 'LMWP 3.1',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.1 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.1',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'xorg-x11-libXmu-32bit' ],
        :rndrelease_version_default => 'LMWP 3.1',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.2 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.2',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl', 'xorg-x11-libXmu' ],
        :rndrelease_version_default => 'LMWP 3.2',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.2 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.2',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'xorg-x11-libXmu-32bit' ],
        :rndrelease_version_default => 'LMWP 3.2',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.3 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.3',
        :architecture               => 'i386',
        :package_name_default       => [ 'tcl', 'xorg-x11-libXmu' ],
        :rndrelease_version_default => 'LMWP 3.3',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.3 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.3',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'xorg-x11-libXmu-32bit' ],
        :rndrelease_version_default => 'LMWP 3.3',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-11.4 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11.4',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'xorg-x11-libXmu-32bit' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
      'SLES-12.0 x86_64' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '12.0',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'libXmu6-32bit' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => '/usr/lib/libtcl8.6.so',
      },
      'SLED-12.0 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '12.0',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'tcl-32bit', 'libXmu6-32bit' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => '/usr/lib/libtcl8.6.so',
      },
    'Solaris 9' =>
      { :operatingsystem            => 'Solaris',
        :operatingsystemrelease     => '5.9',
        :architecture               => 'sun4u',
        :package_name_default       => nil,
        :rndrelease_version_default => 'UMWP 2.0',
        :symlink_target_default     => nil,
        :kernelrelease              => '5.9',
      },
    'Solaris 10' =>
      { :operatingsystem            => 'Solaris',
        :operatingsystemrelease     => '5.10',
        :architecture               => 'sun4u',
        :package_name_default       => nil,
        :rndrelease_version_default => 'UMWP 3.0',
        :symlink_target_default     => nil,
        :kernelrelease              => '5.10',
      },
    'Ubuntu-12.04 x86_64' =>
      { :operatingsystem            => 'Ubuntu',
        :operatingsystemrelease     => '12.04',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'libx11-6:i386', 'libc6:i386' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => nil,
      },
    'Ubuntu-14.04 x86_64' =>
      { :operatingsystem            => 'Ubuntu',
        :operatingsystemrelease     => '14.04',
        :architecture               => 'x86_64',
        :package_name_default       => [ 'libx11-6:i386', 'libc6:i386' ],
        :rndrelease_version_default => nil,
        :symlink_target_default     => nil,
      },
  }

  describe 'with default values for parameters' do
    platforms.sort.each do |k,v|
      context "where operatingsystem is <#{v[:operatingsystem]}-#{v[:operatingsystemrelease]}> on <#{v[:architecture]}>" do
        let :facts do
          { :operatingsystem        => v[:operatingsystem],
            :operatingsystemrelease => v[:operatingsystemrelease],
            :architecture           => v[:architecture],
            :kernelrelease          => v[:kernelrelease],
          }
        end

        it { should compile.with_all_deps }

        # file { 'arc_rndrelease' :}
        if v[:rndrelease_version_default] == nil
          it {
            should contain_file('arc_rndrelease').with({
              'ensure'  => 'absent',
              'path'    => '/etc/rndrelease',
            })
          }
        else
          it {
            should contain_file('arc_rndrelease').with({
              'ensure'  => 'present',
              'path'    => '/etc/rndrelease',
              'mode'    => '0644',
              'content' => "#{v[:rndrelease_version_default]}\n",
            })
          }
        end

        # file { 'arc_symlink' :}
        if v[:symlink_target_default] == nil
          it { should_not contain_file('arc_symlink') }
        else
          it {
            should contain_file('arc_symlink').with({
              'ensure' => 'link',
              'path'   => '/usr/lib/libtcl.so.0',
              'target' => v[:symlink_target_default],
            })
          }
        end

        # Ubuntu specific special specialities
        if v[:operatingsystem] == 'Ubuntu'
          it {
            should contain_file('awk_symlink').with({
              'ensure' => 'link',
              'path'   => '/bin/awk',
              'target' => '/usr/bin/awk',
            })
          }
          it {
            should contain_exec('locale-gen').with({
              'command' => '/usr/sbin/locale-gen en_US',
              'unless'  => 'grep ^en_US\ ISO-8859-1$ /var/lib/locales/supported.d/local',
              'path'    => '/bin:/usr/bin:/sbin:/usr/sbin',
            })
          }
        else
          it { should_not contain_file('awk_symlink') }
          it { should_not contain_exec('locale-gen') }
        end

        # package { '$packages_real': }
        if v[:package_name_default] != nil
          v[:package_name_default].each do |package|
            it {
              should contain_package(package).with({
                'ensure' => 'present',
              })
            }
          end
        end

      end
    end
  end

  describe 'with Solaris specific package attributes' do
    let :facts do
      { :operatingsystem => 'Solaris',
        :kernelrelease   => '5.10',
      }
    end
    let :params do
      { :packages          => [ 'tcl-devel-solaris', 'libXmu-solaris' ],
        :package_adminfile => '/sw/Solaris/Sparc/noask',
        :package_provider  => 'sun',
        :package_source    => '/sw/Solaris/Sparc/arc',
      }
    end

    it { should compile.with_all_deps }

    # package { '$packages_real': }
    [ 'tcl-devel-solaris', 'libXmu-solaris' ].each do |package|
      it {
        should contain_package(package).with({
          'ensure'    => 'present',
          'adminfile' => '/sw/Solaris/Sparc/noask',
          'provider'  => 'sun',
          'source'    => '/sw/Solaris/Sparc/arc',
        })
      }
    end
  end

  describe 'with create_rndrelease set to' do
    ['false',false].each do |value|
      context value do
        let :facts do
          { :operatingsystem        => 'RedHat',
            :operatingsystemrelease => '5',
            :architecture           => 'x86_64',
          }
        end
        let :params do
          { :create_rndrelease => value,
          }
        end

        it { should compile.with_all_deps }

        it {
          should contain_file('arc_rndrelease').with({
            'ensure'  => 'absent',
            'path'    => '/etc/rndrelease',
          })
        }

      end
    end
  end

  describe 'with create_symlink set to' do
    ['false',false].each do |value|
      context value do
        let :facts do
          { :operatingsystem        => 'RedHat',
            :operatingsystemrelease => '5',
            :architecture           => 'x86_64',
          }
        end
        let :params do
          { :create_symlink => value,
          }
        end

        it { should compile.with_all_deps }

        it { should_not contain_file('arc_symlink') }

      end
    end
  end

  describe 'with install_package set to' do
    ['false',false].each do |value|
      context value do
        let :facts do
          { :operatingsystem        => 'RedHat',
            :operatingsystemrelease => '5',
            :architecture           => 'x86_64',
          }
        end
        let :params do
          { :install_package => value,
          }
        end

        it { should compile.with_all_deps }

        it { should_not contain_package('tcl-devel.i386') }
        it { should_not contain_package('libXmu.i386') }

      end
    end
  end

end

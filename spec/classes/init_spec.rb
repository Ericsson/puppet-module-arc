require 'spec_helper'
describe 'arc' do

  # Solaris is intentionaly excluded.
  # It will not manage package { 'arc_package': } with defaults settings only.
  platforms = {
    'RedHat-5 x86_64' =>
      { :operatingsystem            => 'RedHat',
        :operatingsystemrelease     => '5',
        :architecture               => 'x86_64',
        :package_name_default       => 'tcl-devel.i386',
        :rndrelease_version_default => 'LMWP 2.3',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'RedHat-6 x86_64' =>
      { :operatingsystem            => 'RedHat',
        :operatingsystemrelease     => '6',
        :architecture               => 'x86_64',
        :package_name_default       => 'tcl-devel.i686',
        :rndrelease_version_default => 'LMWP 2.3',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLED-10 x86_64' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '10',
        :architecture               => 'x86_64',
        :package_name_default       => 'tcl-32bit',
        :rndrelease_version_default => 'LMWP 2.3',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLED-11 i386' =>
      { :operatingsystem            => 'SLED',
        :operatingsystemrelease     => '11',
        :architecture               => 'i386',
        :package_name_default       => 'tcl',
        :rndrelease_version_default => 'LMWP 3.1',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
    'SLES-10 i386' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '10',
        :architecture               => 'i386',
        :package_name_default       => 'tcl',
        :rndrelease_version_default => 'LMWP 2.3',
        :symlink_target_default     => '/usr/lib/libtcl8.4.so',
      },
    'SLES-11 x86_64' =>
      { :operatingsystem            => 'SLES',
        :operatingsystemrelease     => '11',
        :architecture               => 'x86_64',
        :package_name_default       => 'tcl-32bit',
        :rndrelease_version_default => 'LMWP 3.1',
        :symlink_target_default     => '/usr/lib/libtcl8.5.so',
      },
  }

  describe 'with default values for parameters' do
    platforms.sort.each do |k,v|
      context "where operatingsystem is <#{v[:operatingsystem]}-#{v[:operatingsystemrelease]}> on <#{v[:architecture]}>" do
        let :facts do
          { :operatingsystem        => v[:operatingsystem],
            :operatingsystemrelease => v[:operatingsystemrelease],
            :architecture           => v[:architecture],
          }
        end

        it { should compile.with_all_deps }

        # file { 'arc_rndrelease' :}
        it {
          should contain_file('arc_rndrelease').with({
            'ensure'  => 'present',
            'path'    => '/etc/rndrelease',
            'mode'    => '0644',
            'content' => "#{v[:rndrelease_version_default]}\n",
          })
        }

        # file { 'arc_symlink' :}
        it {
          should contain_file('arc_symlink').with({
            'ensure' => 'link',
            'path'   => '/usr/lib/libtcl.so.0',
            'target' => v[:symlink_target_default],
          })
        }

        # package { 'arc_package': }
        it {
          should contain_package(v[:package_name_default]).with({
            'ensure' => 'present',
          })
        }
      end
    end
  end

  describe "with package attributes set for Solaris usage" do
    let :facts do
      { :operatingsystem        => 'Solaris',
        :operatingsystemrelease => '10_u11',
        :architecture           => '10_u11',
      }
    end
    let :params do
      { :package_name      => 'arc_package_name',
        :package_adminfile => '/sw/Solaris/Sparc/noask',
        :package_provider  => 'sun',
        :package_source    => '/sw/Solaris/Sparc/arc',
        :symlink_target    => '/usr/lib/libdummy2.4.2.so',
      }
    end

    it { should compile.with_all_deps }

    # file { 'arc_rndrelease' :}
    it {
      should contain_file('arc_rndrelease').with({
        'ensure'  => 'present',
        'path'    => '/etc/rndrelease',
        'mode'    => '0644',
        'content' => "UMWP 3.3 Solaris 10_u11 SPARC\n",
      })
    }

    # file { 'arc_symlink' :}
    it {
      should contain_file('arc_symlink').with({
        'ensure' => 'link',
        'path'   => '/usr/lib/libtcl.so.0',
        'target' => '/usr/lib/libdummy2.4.2.so',
      })
    }

    # package { 'arc_package': }
    it {
      should contain_package('arc_package_name').with({
        'ensure'    => 'present',
        'adminfile' => '/sw/Solaris/Sparc/noask',
        'provider'  => 'sun',
        'source'    => '/sw/Solaris/Sparc/arc',
      })
    }

  end
end

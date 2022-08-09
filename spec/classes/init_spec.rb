require 'spec_helper'
describe 'arc' do
  on_supported_os.sort.each do |os, os_facts|
    # OS specific module defaults
    case os
    when 'centos-5-x86_64', 'redhat-5-x86_64'
      packages = [ 'libXmu.i386', 'tcl-devel.i386', 'tcsh' ]
      rndrelease_version = nil
      symlink_target = '/usr/lib/libtcl8.4.so'
    when 'centos-6-x86_64', 'redhat-6-x86_64'
      packages = [ 'libXmu.i686', 'tcl-devel.i686', 'tcsh' ]
      rndrelease_version = nil
      symlink_target = '/usr/lib/libtcl8.5.so'
    when 'centos-7-x86_64', 'redhat-7-x86_64'
      packages = [ 'tcsh', 'libX11.i686' ]
      rndrelease_version = nil
      symlink_target = nil
    when 'centos-8-x86_64', 'redhat-8-x86_64'
      packages = [ 'tcsh', 'libX11.i686', 'libxcrypt.i686', 'libnsl.i686' ]
      rndrelease_version = nil
      symlink_target = nil
    when 'sles-10-x86_64'
      packages = [ 'tcl-32bit', 'tcsh' ]
      rndrelease_version = 'LMWP 2.0'
      symlink_target = '/usr/lib/libtcl8.4.so'
    when 'sles-11-x86_64'
      packages = [ 'tcl-32bit', 'tcsh', 'xorg-x11-libXmu-32bit' ]
      rndrelease_version = 'LMWP 3.3'
      symlink_target = '/usr/lib/libtcl8.5.so'
    when 'sles-12-x86_64', 'sles-15-x86_64'
      packages = [ 'tcl-32bit', 'tcsh', 'libXmu6-32bit' ]
      rndrelease_version = nil
      symlink_target = '/usr/lib/libtcl8.6.so'
    when 'ubuntu-12.04-x86_64', 'ubuntu-14.04-x86_64', 'ubuntu-16.04-x86_64', 'ubuntu-18.04-x86_64', 'ubuntu-20.04-x86_64'
      packages = [ 'libx11-6:i386', 'libc6:i386', 'tcsh', 'tcl-dev' ]
      rndrelease_version = nil
      symlink_target = nil
    end

    context "on #{os} with default values for parameters" do
      let(:facts) { os_facts }

      it { is_expected.to compile.with_all_deps }

      if rndrelease_version.nil?
        it { is_expected.to contain_file('arc_rndrelease').with_ensure('absent') }
      else
        it do
          is_expected.to contain_file('arc_rndrelease').only_with(
            {
              'ensure'  => 'present',
              'path'    => '/etc/rndrelease',
              'mode'    => '0644',
              'content' => "#{rndrelease_version}\n",
            },
          )
        end
      end

      if symlink_target.nil?
        it { is_expected.not_to contain_file('arc_symlink') }
      else
        it do
          is_expected.to contain_file('arc_symlink').only_with(
            {
              'ensure' => 'link',
              'path'   => '/usr/lib/libtcl.so.0',
              'target' => symlink_target,
            },
          )
        end
      end

      # Ubuntu specific special specialities
      if os_facts[:os]['name'] == 'Ubuntu'
        if os_facts[:os]['release']['full'].match?(%r{^(10|12|14|16|18)})
          it do
            is_expected.to contain_file('awk_symlink').only_with(
              {
                'ensure' => 'link',
                'path'   => '/bin/awk',
                'target' => '/usr/bin/awk',
              },
            )
          end
        end

        it do
          is_expected.to contain_exec('locale-gen').only_with(
            {
              'command' => '/usr/sbin/locale-gen en_US',
              'unless'  => '/usr/bin/locale -a |grep -q ^en_US.iso88591$',
              'path'    => '/bin:/usr/bin:/sbin:/usr/sbin',
            },
          )
        end
      else
        it { is_expected.not_to contain_file('awk_symlink') }
        it { is_expected.not_to contain_exec('locale-gen') }
      end

      packages.each do |package|
        it { is_expected.to contain_package(package).with_ensure('present') }
      end
    end
  end

  # The following tests are OS independent, so we only test one
  redhat = {
    supported_os: [
      {
        'operatingsystem'        => 'RedHat',
        'operatingsystemrelease' => ['7'],
      },
    ],
  }

  on_supported_os(redhat).each do |_os, os_facts|
    let(:facts) { os_facts }

    context 'with create_rndrelease set to false' do
      let(:params) { { create_rndrelease: false } }

      it { is_expected.to contain_file('arc_rndrelease').with_ensure('absent') }
    end

    context 'with manage_arc_console_icon set to true' do
      context 'when arc_console_icon is set to true' do
        let :params do
          {
            manage_arc_console_icon: true,
            arc_console_icon:        true,
          }
        end

        it do
          is_expected.to contain_file('arc_console.desktop').only_with(
            {
              'ensure' => 'file',
              'path'   => '/usr/share/applications/arc_console.desktop',
              'mode'   => '0644',
              'owner'  => 'root',
              'group'  => 'root',
              'source' => 'puppet:///modules/arc/arc_console.desktop',
            },
          )
        end
      end

      context 'when arc_console_icon is set to false' do
        let :params do
          {
            manage_arc_console_icon: true,
            arc_console_icon:        false,
          }
        end

        it do
          is_expected.to contain_file('arc_console.desktop').only_with(
            {
              'ensure' => 'absent',
              'path'   => '/usr/share/applications/arc_console.desktop',
            },
          )
        end
      end
    end

    context 'with manage_arc_console_icon set to false' do
      let(:params) { { manage_arc_console_icon: false } }

      it { is_expected.not_to contain_file('arc_console.desktop') }
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
  end
end

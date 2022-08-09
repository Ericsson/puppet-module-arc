require 'spec_helper'
describe 'arc' do
  describe 'variable type and content validations' do
    # The following tests are OS independent, so we only test one supported OS
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

      validations = {
        'Optional[Stdlib::Absolutepath]' => {
          name:    ['symlink_target'],
          valid:   ['/absolute/filepath', '/absolute/directory/'],
          invalid: [['/array', '/with/paths'], '../invalid', 3, 2.42, ['array'], { 'ha' => 'sh' }, true, false, nil],
          message: 'expects a (match for|match for Stdlib::Absolutepath =|Stdlib::Absolutepath =) Variant\[Stdlib::Windowspath.*Stdlib::Unixpath',
        },
        'Optional[Array[String[1]]]' => {
          name:    ['packages'],
          valid:   [['tcsh', 'libX11.i686'], :undef],
          invalid: ['string', { 'ha' => 'sh' }, 3, 2.42, true],
          message: 'Undef or Array|expects a String value|Error while evaluating a Resource Statement',
        },
        'Boolean' => {
          name:    ['arc_console_icon', 'create_rndrelease', 'create_symlink', 'install_package', 'manage_arc_console_icon', 'manage_rndrelease'],
          valid:   [true, false],
          invalid: ['true', 'string', ['array'], { 'ha' => 'sh' }, 3, 2.42, nil],
          message: 'expects a Boolean value',
        },
      }

      validations.sort.each do |type, var|
        mandatory_params = {} if mandatory_params.nil?
        var[:name].each do |var_name|
          var[:params] = {} if var[:params].nil?
          var[:valid].each do |valid|
            context "when #{var_name} (#{type}) is set to valid #{valid} (as #{valid.class})" do
              let(:facts) { [mandatory_facts, var[:facts]].reduce(:merge) } unless var[:facts].nil?
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
        end
      end # var[:name].each
    end # validations.sort.each
  end # describe 'validate data types of parameters'
end

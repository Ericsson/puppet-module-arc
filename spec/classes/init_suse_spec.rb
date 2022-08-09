# For SLED/SLES we need individual tests for each affected minor release.
# Since this is not possible with rspec-puppet-facts, explicit tests are
# necessary here. The parameters $rndrelease_version (release) is affected.

require 'spec_helper'
describe 'arc' do
  platforms = {
    'SLED-11.0 x86_64' => {
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
    'SLED-11.1 x86_64' => {
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
    'SLED-11.2 x86_64' => {
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
    'SLED-11.3 x86_64' => {
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

        it do
          is_expected.to contain_file('arc_rndrelease').with(
            {
              'content' => "#{v[:rndrelease_version_default]}\n",
            },
          )
        end
      end
    end
  end
end

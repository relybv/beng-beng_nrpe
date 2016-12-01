require 'spec_helper'

describe 'beng_nrpe' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts.merge({
            :concat_basedir => "/foo"
          })
        end

        context "beng_nrpe class without any parameters" do
          let(:params) {{ }}

          it { is_expected.to compile.with_all_deps }
          it { is_expected.to contain_class('beng_nrpe') }
 
          it { is_expected.to contain_class('beng_nrpe::params') }
          it { is_expected.to contain_class('beng_nrpe::install').that_comes_before('beng_nrpe::config') }
          it { is_expected.to contain_class('beng_nrpe::config') }
          it { is_expected.to contain_class('beng_nrpe::service').that_subscribes_to('beng_nrpe::config') }

          it { is_expected.to contain_service('beng_nrpe') }
          it { is_expected.to contain_package('beng_nrpe').with_ensure('present') }

        end
      end
    end
  end
end

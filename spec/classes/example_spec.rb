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
          it { is_expected.to contain_class('snmp') }
 
          it { is_expected.to contain_class('beng_nrpe::params') }
          it { is_expected.to contain_class('beng_nrpe::install') }
          it { is_expected.to contain_class('beng_nrpe::config') }
          it { is_expected.to contain_class('beng_nrpe::service') }

          case facts[:operatingsystemrelease]
          when /^6.*/
            it { is_expected.to contain_class('beng_nrpe::install::rh6') }
            it { is_expected.to contain_class('beng_nrpe::config::rh6') }

            it { is_expected.to contain_package('perl-Crypt-DES') }
            it { is_expected.to contain_package('perl-Digest-HMAC') }
            it { is_expected.to contain_package('perl-Digest-SHA1') }
            it { is_expected.to contain_package('perl-Digest-SHA1') }
            it { is_expected.to contain_package('perl-Net-SNMP') }
            it { is_expected.to contain_package('vdl-nagios-common') }
            it { is_expected.to contain_package('vdl-nagios-plugins') }
            it { is_expected.to contain_package('vdl-nrpe-plugin') }
            it { is_expected.to contain_package('vdl-nrpe') }

            it { is_expected.to contain_exec('retrieve_checks') }
            it { is_expected.to contain_exec('retrieve_config') }
          else
            it { is_expected.to contain_class('beng_nrpe::install::rh7') }
            it { is_expected.to contain_class('beng_nrpe::config::rh7') }

            it { is_expected.to contain_yumrepo('epel-latest-7') }

            it { is_expected.to contain_package('nagios-plugins-all') }
            it { is_expected.to contain_package('nrpe') }

            it { is_expected.to contain_file('/etc/nagios/nrpe.cfg') }
            it { is_expected.to contain_file('/etc/nrpe.d/local_commands.cfg') }
            it { is_expected.to contain_file('/usr/lib64/nagios/plugins/check_memory.sh') }
            it { is_expected.to contain_file('/usr/lib64/nagios/plugins/check_uptime.sh') }
            it { is_expected.to contain_file('/usr/lib64/nagios/plugins/utils.sh') }
          end

          it { is_expected.to contain_service('nrpe') }

        end
      end
    end
  end
end

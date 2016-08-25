require 'spec_helper'

describe 'oraaud' do
  let(:params) {
    {
      dir_src:          '/fslink/sysinfra/oracle/scripts/misc/auditing',
      dir_audit:        '/home/oracle/system/audit',
      script_audit:     'install_ora_audit.sh',
      script_compare:   'version_compare.sh',
      script_cycle_db:  'cycle_db.sh',
      script_marker_rm: 'marker_rm.sh',
      file_tar:         'rn-ora_audit_nitc.tar',
      path_default:     '/usr/local/sbin:/usr/local/bin:/sbin:/bin:/usr/sbin:/usr/bin:/root/bin',
      expect_package:   'expect',
      expect_ensure:    'present',
      db_user:          'oracle',
      db_group:         'oinstall'
    }
  }

  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "oraaud class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('oraaud::params') }
          it { is_expected.to contain_class('oraaud::install').that_comes_before('oraaud::config') }
          it { is_expected.to contain_class('oraaud::config').that_comes_before('oraaud::service') }
          it { is_expected.to contain_class('oraaud::service') }

          # it { is_expected.to contain_service('oraaud') }
          # it { is_expected.to contain_package('oraaud').with_ensure('present') }
        end
      end
    end
  end

  # context 'unsupported operating system' do
  #   describe 'oraaud class without any parameters on Solaris/Nexenta' do
  #     let(:facts) do
  #       {
  #         :osfamily        => 'Solaris',
  #         :operatingsystem => 'Nexenta',
  #       }
  #     end

  #     it { expect { is_expected.to contain_package('oraaud') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
  #   end
  # end
end

require 'spec_helper'

describe 'ora_audit' do
  context 'supported operating systems' do
    on_supported_os.each do |os, facts|
      context "on #{os}" do
        let(:facts) do
          facts
        end

        context "ora_audit class without any parameters" do
          it { is_expected.to compile.with_all_deps }

          it { is_expected.to contain_class('ora_audit::params') }
          it { is_expected.to contain_class('ora_audit::install').that_comes_before('ora_audit::config') }
          it { is_expected.to contain_class('ora_audit::config') }
          it { is_expected.to contain_class('ora_audit::service').that_subscribes_to('ora_audit::config') }

          it { is_expected.to contain_service('ora_audit') }
          it { is_expected.to contain_package('ora_audit').with_ensure('present') }
        end
      end
    end
  end

  context 'unsupported operating system' do
    describe 'ora_audit class without any parameters on Solaris/Nexenta' do
      let(:facts) do
        {
          :osfamily        => 'Solaris',
          :operatingsystem => 'Nexenta',
        }
      end

      it { expect { is_expected.to contain_package('ora_audit') }.to raise_error(Puppet::Error, /Nexenta not supported/) }
    end
  end
end

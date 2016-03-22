require 'spec_helper'
describe 'oraaud' do

  context 'with defaults for all parameters' do
    it { should contain_class('oraaud') }
  end
end

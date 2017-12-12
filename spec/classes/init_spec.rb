require 'spec_helper'
describe 'apt_dater' do
  context 'with default values for all parameters' do
    it { should contain_class('apt_dater') }
  end
end

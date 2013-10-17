require 'spec_helper'

describe 'chef_cookbook_template::default' do
  let(:chef_run) { runner.converge 'chef_cookbook_template::default' }

  it "does something" do
    pending "I pity the fool who doesn't write specs!"
  end
end

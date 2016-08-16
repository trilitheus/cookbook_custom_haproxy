#
# Cookbook Name:: haproxy
# Spec:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.

require 'spec_helper'

describe 'haproxy::default' do
  context 'When all attributes are default on RHEL family' do
    let(:chef_run) do
      runner = ChefSpec::ServerRunner.new
      runner.node.automatic['os'] = 'linux'
      runner.node.automatic['platform_family'] = 'rhel'
      runner.node.automatic['virtualization']['system'] = 'docker'
      runner.converge(described_recipe)
    end

    it 'installs the haproxy package' do
      expect(chef_run).to install_package('haproxy')
    end
  end
end

#
# Cookbook Name:: custom_haproxy
# Recipe:: default
#
# Copyright (c) 2016 The Authors, All Rights Reserved.
include_recipe 'haproxy::install_source'

secrets = {}
front_ends = node['haproxy']['frontends']
front_ends['https'].each do |fe, opts|
  if 'kitchen'.include?(node.chef_environment)
    secrets[fe] = Chef::DataBagItem.load("#{node.chef_environment}_certs", opts['certbagitem'])
  else
    secret_file = Chef::EncryptedDataBagItem.load_secret(node['secret_file'])
    secrets[fe] = Chef::EncryptedDataBagItem.load("#{node.chef_environment}_certs", opts['certbagitem'], secret_file)
  end
end

%w(ssl errors).each do |dir|
  directory "/etc/haproxy/#{dir}" do
    user 'root'
    group 'root'
    mode '700'
    recursive true
  end
end

front_ends['https'].each do |fe, opts|
  file "/etc/haproxy/ssl/#{opts['certfile']}" do
    user 'root'
    group 'root'
    mode '00400'
    content secrets[fe]['content']
  end
end

cookbook_file '/etc/haproxy/errors/503.http' do
  user 'root'
  group 'root'
  mode '00640'
end

service 'haproxy' do
  action [:start, :enable]
end

template '/etc/haproxy/haproxy.cfg' do
  user 'root'
  group 'root'
  mode '00644'
  variables(
    frontends: node['haproxy']['frontends'],
    backends: node['haproxy']['backends']
  )
  notifies :restart, 'service[haproxy]', :delayed
end

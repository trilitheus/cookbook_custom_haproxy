# No requirement to use internal firewall on openstack
service 'firewalld' do
  action [:stop, :disable]
end

include_recipe 'custom_haproxy::keepalived'
include_recipe 'custom_haproxy::haproxy'

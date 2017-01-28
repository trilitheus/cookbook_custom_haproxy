node_prefix = 'lb-'
# VIP Address is static assigned on openstack DMZ network
vip_address = node['custom_haproxy']['dmz_vip']
router_id = 1

include_recipe 'keepalived'

node.default['keepalived']['check_scripts']['chk_haproxy'] = {
  :script => 'killall -0 haproxy',
  :interval => 2,
  :weight => 2
}

node.default['keepalived']['instances']['ha_vip'] = {
  :ip_addresses => vip_address,
  :interface => node['network']['default_interface'],
  :state => 'MASTER',
  :states => {
    "#{node_prefix}01" => :master,
    "#{node_prefix}02" => :backup
  },
  :virtual_router_ids => {
    "#{node_prefix}01" => router_id,
    "#{node_prefix}02" => router_id
  },
  'priorities' => {
    "#{node_prefix}01" => 100,
    "#{node_prefix}02" => 50
  },
  :track_script => 'chk_haproxy',
  :nopreempt => false,
  :advert_int => 1,
  :auth_type => :pass,
  :auth_pass => 'MUHAHAHAHA'
}

# This file is only used when running chef in local mode during image creation
cookbook_path '/home/vagrant/cookbooks'
data_bag_path '/home/vagrant/cookbooks/custom_haproxy/data_bags'
environment_path '/home/vagrant/cookbooks/custom_haproxy/environments'
environment 'kitchen'
local_mode 'true'
log_level :info

#
# Cookbook Name:: redis
# Recipe:: default
#
# Copyright (C) 2013 Julian Tescher
# 
# License: MIT
#

#http://redis.googlecode.com/files/redis-2.6.14.tar.gz
src_url = node[:redis][:source_url] || "http://redis.googlecode.com/files/redis-#{node[:redis][:version]}.tar.gz"
src_filepath  = "#{Chef::Config['file_cache_path'] || '/tmp'}/redis-#{node[:redis][:version]}.tar.gz"
src_dir = "#{Chef::Config['file_cache_path'] || '/tmp'}/redis-#{node[:redis][:version]}"

include_recipe 'build-essential'

# Download Redis from source
remote_file src_url do
  source src_url
  checksum node[:redis][:source_checksum]
  path src_filepath
  action :create_if_missing
end

# Unpack Redis
bash "unpack redis from #{src_filepath}" do
  cwd Chef::Config[:file_cache_path] || '/tmp'
  code "tar -zxf #{src_filepath}"
  not_if { ::FileTest.exists?(src_dir) }
end

# Install Redis
execute 'install-redis' do
  cwd src_dir
  command "make PREFIX=#{node[:redis][:install_dir]} install"
  creates "#{node[:redis]['install_dir']}/redis-server"
end

# Make Redis
execute 'make-redis' do
  cwd src_dir
  command 'make'
  creates 'redis'
end

# Create Redis user
user node[:redis][:user] do
  home node[:redis][:install_dir]
  comment 'Redis Administrator'
  supports :manage_home => false
  system true
end

# Own install directory
directory node[:redis][:install_dir] do
  owner node[:redis][:user]
  group node[:redis][:group]
  recursive true
end

# Create Redis configuration directory
directory node[:redis][:conf_dir] do
  owner 'root'
  group 'root'
  mode '0755'
end

# Create Redis database directory
directory node[:redis][:db_dir] do
  owner node[:redis][:user]
  mode '0750'
end

# Write config file and restart Redis
template '/etc/init.d/redis' do
  source 'redis_init_script.erb'
  mode '0744'
end

# Write config file and restart Redis
template "#{node[:redis][:conf_dir]}/#{node[:redis][:port]}.conf" do
  source 'redis.conf.erb'
  mode '0644'
end

# Set up redis service
service 'redis' do
  supports :reload => false, :restart => true, :start => true, :stop => true
  action [ :enable, :start ]
end

# Ensure change notifies redis to restart (Comes after resource decliration for OpsWorks chef ~ 9.15) :(
template "#{node[:redis][:conf_dir]}/#{node[:redis][:port]}.conf" do
  notifies :restart, resources(:service => 'redis')
end

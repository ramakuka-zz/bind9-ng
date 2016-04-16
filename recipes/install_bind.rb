#
# Cookbook Name:: bind9
# Recipe:: default
#
# Copyright 2013, Deutsche Telekom HBS Inc
#
# All rights reserved - Do Not Redistribute
#
node['bind9']['packages'].each do |pkg|
  package pkg
end

directory node['bind9']['loglocation'] do
  owner node['bind9']['user']
  group node['bind9']['group']
end

directory node[:bind9][:zonedir] do
  owner node['bind9']['user']
  group node['bind9']['group']
end

template node['bind9']['sysconfig'] do
  source "named_sysconfig_rhel.erb" if platform_family?("rhel")
  source "named_sysconfig_debian.erb" if platform_family?("debian")
  owner "root"
  group "root"
end

service node['bind9']['service_name'] do
  supports :status => true, :reload => true, :restart => true, :enable => true
  action :enable
end

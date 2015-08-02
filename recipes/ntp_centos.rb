#
# Cookbook Name:: gs
# Recipe:: ntp_centos
# Nate Delgado
#
# goatscript@gmail.com
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

package "ntp" do
  action [:install]
end

template "/etc/ntp.conf" do
  source "ntp.conf.erb"
  variables( :ntp_server => node[:ntp][:ip])
  notifies :restart, "service[ntpd]"
end

service "ntpd" do
  action [:enable, :start]
end

link "/etc/localtime" do
  to "/usr/share/zoneinfo/#{node[:ntp][:timezone]}"
end

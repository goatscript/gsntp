# 
# Cookbook Name:: gsntp
# Recipe:: default
# Nate Delgado
#
# goatscript@gmail.com
# Copyright (c) 2015 The Authors, All Rights Reserved.



case node['platform']
  
when 'windows'
  include_recipe 'gsntp::ntp_win'

when 'centos'
  include_recipe 'gsntp::ntp_centos'
end

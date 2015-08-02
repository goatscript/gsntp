#
# Cookbook Name:: gsntp
# Recipe:: ntp_win
# Nate Delgado
#
# goatscript@gmail.com
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

::Chef::Recipe.send(:include, Windows::Helper)

batch "time_change" do
  code <<-EOH
    w32tm /config /update /manualpeerlist:#{node[:ntp][:ip]},0x8 /syncfromflags:MANUAL /reliable:yes
    net stop w32time
    net start w32time
    EOH
  action :run
  not_if {registry_data_exists?('HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\w32Time\\Parameters', {:name => "NtpServer", :type => :string, :data => "0.0.0.0,0x8"})}
  notifies :run, "batch[time_resync]", :immediately
end

if node['platform_version'].to_f < 6
    registry_key 'HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\TimeZoneInformation' do
      values [{:name => "ActiveTimeBias", :type => :dword, :data => "#{node[:ntp][:w2k3][:ActiveTimeBias]}".to_i},
              {:name => "Bias", :type => :dword, :data => "#{node[:ntp][:w2k3][:Bias]}".to_i},
              {:name => "DaylightName", :type => :string, :data => "#{node[:ntp][:w2k3][:DaylightName]}"},
              {:name => "DaylightStart", :type => :binary, :data => "#{node[:ntp][:w2k3][:DaylightStart]}"},
              {:name => "StandardName", :type => :string, :data => "#{node[:ntp][:w2k3][:StandardName]}"},
              {:name => "TimeZoneKeyName", :type => :string, :data => "#{node[:ntp][:w2k3][:TimeZoneKeyName]}"}
             ]
    action :create
    notifies :run, "batch[time_resync]", :immediately
  end
elsif node['platform_version'].to_f > 6
  registry_key 'HKEY_LOCAL_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\TimeZoneInformation' do
      values [{:name => "ActiveTimeBias", :type => :dword, :data => "#{node[:ntp][:w2k8][:ActiveTimeBias]}".to_i},
              {:name => "Bias", :type => :dword, :data => "#{node[:ntp][:w2k8][:Bias]}".to_i},
              {:name => "DaylightBias", :type => :dword, :data => "#{node[:ntp][:w2k8][:DaylightBias]}".to_i},
              {:name => "DaylightName", :type => :string, :data => "#{node[:ntp][:w2k8][:DaylightName]}"},
              {:name => "DaylightStart", :type => :binary, :data => "#{node[:ntp][:w2k8][:DaylightStart]}"},
              {:name => "DynamicDaylight", :type => :dword, :data => "#{node[:ntp][:w2k8][:DynamicDaylight]}".to_i},
              {:name => "StandardBias", :type => :dword, :data => "#{node[:ntp][:w2k8][:StandardBias]}".to_i},
              {:name => "StandardName", :type => :string, :data => "#{node[:ntp][:w2k8][:StandardName]}"},
              {:name => "StandardStart", :type => :binary, :data => "#{node[:ntp][:w2k8][:StandardStart]}"},
              {:name => "TimeZoneKeyName", :type => :string, :data => "#{node[:ntp][:w2k8][:TimeZoneKeyName]}"}
             ]
    action :create
    notifies :run, "batch[time_resync]", :immediately
  end
end

batch "time_resync" do
  code <<-EOH
    w32tm /resync
    EOH
  action :nothing
end

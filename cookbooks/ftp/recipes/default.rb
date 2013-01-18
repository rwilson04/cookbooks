#
# Cookbook Name:: ftp
# Recipe:: default
#
# Copyright 2012, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
package "vsftpd" do
	action :install
end

service "vsftpd" do
	supports :start => true, :stop => true, :restart => true
	action [:enable, :start]
end

template "/etc/vsftpd/vsftpd.conf" do
	source "vsftpd.conf"
	owner "root"
	group "root"
	mode 0640
	notifies :restart, "service[vsftpd]"
end

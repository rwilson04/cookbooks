#
# Cookbook Name:: mysql
# Recipe:: server_webapp
#
# Copyright 2008-2009, Opscode, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
#include_recipe "mysql::server"
package "mysql-server" do
    action :install
end                                                                                                                                                                                                               

service "mysqld" do
	supports :start => true, :stop => true, :restart => true, :status => true
	action [:enable, :start]
end

execute "echo" do
	command "echo if mysql just installed, run 'sudo mysqladmin -u root password NEWPASSWORD'"
end

# micro instances will crash unless there is some swap space
execute "swap" do
	if File.exists?("/swapfile")
		puts("swapfile exists")
		action :nothing
	else
		puts("creating swapfile")
		command "dd if=/dev/zero of=/swapfile bs=1M count=1024; mkswap /swapfile; swapon /swapfile; echo '/swapfile swap swap defaults 0 0' >> /etc/fstab"
	end
end

username = "reese"
uid = 8282
gid = "reese"
#users_manage "#{username}" do #doesn't seem to work with chef-solo
        #comment "Reese Wilson"
        #uid=1082
        #shell "/bin/bash"
        #home "/home/reesew"
        #data_bag "reese"
        #group_id 8282
        #action [:remove, :create]
        #action [:create]
#end

user "#{username}" do
	uid "#{uid}"
	gid "#{gid}"
	username "#{username}"
	home "/home/#{username}"
	shell "/bin/bash"
	action :create
end

group "sysadmin" do
	action :modify
	members "reese"
	append true
end

group "developers" do
	action :modify
	members "reese"
	append true
end

directory "/home/#{username}/.ssh" do
        owner "#{username}"
        group "#{username}"
        mode "0755"
        action :create
end

execute "key" do
	if File.exists?("/home/ec2-user/.ssh/authorized_keys")
		command "cp /home/ec2-user/.ssh/authorized_keys /home/#{username}/.ssh/authorized_keys; chown reese:reese /home/#{username}/.ssh/authorized_keys"
	else
		command "cp /home/ubuntu/.ssh/authorized_keys /home/#{username}/.ssh/authorized_keys; chown reese:reese /home/#{username}/.ssh/authorized_keys"
	end
end

package "vim" do
        action [:install]
end

bash "vimrc" do
        code <<-EOH
                wget -O- http://dl.dropbox.com/u/18732005/.vimrc > /home/#{username}/.syncedvimrc
        EOH
        #action :nothing
end

directory "/home/#{username}/.vim" do
        owner "#{username}"
        group "#{username}"
        mode "0755"
        action :create
end

#
#add custom user files
%w{vim.zip .vimrc .screenrc .bashrc .bash_aliases .inputrc .gitconfig .ssh/config}.each do |file|
        cookbook_file "#{username}/#{file}" do
                source "#{username}/#{file}"
                path "/home/#{username}/#{file}"
                owner "#{username}"
                group "#{username}"
                mode "0644"
        end
end

execute "vimfiles" do
        command "unzip /home/#{username}/vim.zip -d /home/#{username}/.vim; rm /home/#{username}/vim.zip; chown -R #{username}:#{username} /home/#{username}/.vim; "
end


#cookbook_file "#{username}/.ssh/github.pem" do
#        source "#{username}/.ssh/github.pem"
#        path "/home/#{username}/.ssh/github.pem"
#        owner "#{username}"
#        group "#{username}"
#        mode "0600"
#end


template ".bash_profile" do
        path "/home/#{username}/.bash_profile"
        source ".bash_profile.erb"
        owner "#{username}"
        group "#{username}"
        mode "0644"
        variables({
                :name => node['name']
        })
end


#cookbook_file "#{username}/.ssh/github.pem" do
#       source "#{username}/.ssh/github.pem"
#       path "/home/#{username}/.ssh/github.pem"
#       owner "#{username}"
#       group "#{username}"
#       mode "0644"
#end


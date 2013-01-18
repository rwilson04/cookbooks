username = "julian"
uid = 8283
gid = "julian"
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
group "#{gid}" do
	gid "#{uid}"
	action :create
end

user "#{username}" do
	uid "#{uid}"
	gid "#{gid}"
	username "#{username}"
	home "/home/#{username}"
	shell "/bin/bash"
	action :create
end

group "#{username}" do
	action :modify
	members "#{username}"
	append true
end

group "developers" do
	action :modify
	members "#{username}"
	append true
end

cookbook_file "#{username}/.ssh/authorized_keys" do
        source "#{username}/.ssh/authorized_keys"
        path "/home/#{username}/.ssh/authorized_keys"
        owner "#{username}"
        group "#{username}"
        mode "0600"
end

directory "/home/#{username}/web" do
        owner "#{username}"
        group "#{username}"
        mode "0755"
        action :create
end

execute "map" do
	if File.directory?("/var/www/html/idc")
		command "mount --bind /var/www/html/idc /home/#{username}/web"
	else
		command "echo /var/www/html/idc does not exist"
	end
end

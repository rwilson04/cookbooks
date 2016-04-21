
include_recipe "mysql::server_webapp"
include_recipe "users::developers"

package "php-mcrypt" do
    action :install
end                                                                                                                                                                                                               

package "php-mbstring" do
    action :install
end                                                                                                                                                                                                               

package "php-xml" do
    action :install
end                                                                                                                                                                                                               

package "php-mysql" do
    action :install
end                                                                                                                                                                                                               

package "php-mysqli" do
    action :install
end                                                                                                                                                                                                               


app_dir = "/var/www/html/food"

# disable default site
apache_site "default" do
    enable false
end

#should be created by web_app resource
directory "#{app_dir}" do
	owner "apache"
	group "developers"
	mode "0755"
	action :create
end


web_app "food-site" do
    server_name "food.shinymayhem.com"
	#template "phpmyadmin_web_app.conf.erb"
    server_aliases [ node['hostname'], node['dqdn'] ]
	allow_override "All"
    docroot "#{app_dir}/public"
	#phpmyadminroot "#{app_dir}/phpmyadmin"
    directory_index "index.php"
end

package "git" do
    action :install
end

#only change ownership from root:root to root:developers
execute "own" do
    command "chown -R --from root:root root:developers #{app_dir}; chmod g+w #{app_dir}"
end

#all files written in this directory will be owned by the developers group
execute "groupwrite" do
    command "chmod -R g+s #{app_dir}"
end

execute "apache-own" do #if directories exist, have apache be the owner for writing logs, etc
    command "if [ -r #{app_dir}/logs ]; then
     chown -R apache:developers #{app_dir}/logs; 
    fi 
    if [ -r #{app_dir}/logs ]; then
        chown -R apache:developers #{app_dir}/data
    fi 
    if [ -r #{app_dir}/public/cache ]; then
        chown -R apache:developers #{app_dir}/public/cache
    fi "
end


execute "writeable" do #writeable to developers group
    command "find #{app_dir} -group developers | xargs chmod g+w"
end

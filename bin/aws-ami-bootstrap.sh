sudo yum update
sudo yum install ruby
sudo yum install ruby ruby-devel ruby-ri ruby-rdoc ruby-shadow gcc gcc-c++ autoconf make curl dmidecode
mkdir src
cd src/
curl -O http://production.cf.rubygems.org/rubygems/rubygems-1.8.10.tgz
tar zxf rubygems-1.8.10.tgz
cd rubygems-1.8.10
sudo ruby setup.rb --no-format-executable
sudo gem install chef --no-ri --no-rdoc
sudo yum install git
git config --global user.name "Reese"
git config --global user.email "reese@shinymayhem.com"
cd 
mkdir chef
cd chef
git init
git remote add origin https://github.com/shinymayhem/cookbooks.git
git fetch
git checkout master
echo "now run update solo.json and run sudo bin/chef-update.sh"

To set up github to allow editing/pushing, go to the deploygithub directory and run
openssl enc -d -aes-256-cbc -in github.pem.enc -out github.pem  #with numeral password
cp .git/config ../.git/config
cp .ssh/config ~/.ssh/config

encrypt data bags with 
openssl enc -aes-256-cbc -salt -in file.ext -out github.pem.enc
openssl enc -d -aes-256-cbc -in github.pem.enc -out github


edit solo.json as appropriate for the local node, then run
chef-solo -c solo.rb -j solo.json

encryption
openssl enc -d -aes-256-cbc -in file.ext.enc -out file.ext
openssl enc -aes-256-cbc -salt -in file.ext -out file.ext.enc

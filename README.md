# zookeepr-chef
chef code for running zookeepr

#Instructions

1. create key named ``test`` in aws store in zookeepr/chef/.chef/test.pem
2. ssh-add the key to the ssh agent
3. setup your ~/.ssh/config like this 

    Host ec2*compute-1.amazonaws.com
      StrictHostKeyChecking no
      User admin
      IdentityFile  /mnt/data/home/mdupont/experiments/zookeepr/chef/.chef/test.pem


see
http://gerhardlazu.com/2010/08/using-chef-to-manage-amazon-ec2-instances-part2/
http://scottwb.com/blog/2012/12/13/provision-and-bootstrap-windows-ec2-instances-with-chef/


# .chef/knife

```
cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
client_key       "key.pem"
local_mode true
node_name 'mdupont-Aspire-7750G'

log_level                :debug
log_location             STDOUT

#encrypted_data_bag_secret "data_bag_key"
chef_client_path 'chef-client -l debug'

knife[:berkshelf_path] = "cookbooks"
knife[:aws_credential_file]   = "/home/mdupont/.aws/credentials"
knife[:image] = "ami-896d85e2zz"
knife[:ssh_user] = "admin" 
# Default flavor of server (m1.small, c1.medium, etc).
knife[:flavor] = "t1.micro"
#knife[:aws_ssh_key_id] = "test1"
knife[:aws_ssh_key_name] = "test"
knife[:ssh_key_name] = "test"

# Default AMI identifier, e.g. ami-12345678
knife[:image] = "ami-896d85e2"

# AWS Region
knife[:region] = "us-east-1"

# AWS Availability Zone. Must be in the same Region.
knife[:availability_zone] = "us-east-1a"
knife[:validation_key] = "/dev/null"

Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef
#knife[:verbose_commands] 	 
knife[:verbosity] =999

identity_file = 'test.pem'
```


# vagrant

provisioning on vagrant

    bundle exec knife vagrant server create --box "ARTACK/debian-jessie" -N test -rtest --ssh-user vagrant

# Git Sub modules

Using these modules from git, install via git clone and gem

* github.com/h4ck3rm1k3/knife-vagrant2

# bootstrap on vagrant

bootstrap

    bundle exec knife zero bootstrap 192.168.67.2 --ssh-user vagrant --sudo

connect to :
    bundle exec knife ssh 'name:test' -VV ifconfig -x vagrant -a ipaddress


but first :

   vagrant/test$ bundle exec vagrant ssh-config


it generates

    Host default


Next, change the Host to the name of the node:

```

Host test
  HostName 127.0.0.1
  User vagrant
  Port 2222
  UserKnownHostsFile /dev/null
  StrictHostKeyChecking no
  PasswordAuthentication no
  IdentityFile /mnt/data/home/mdupont/experiments/zookeepr/chef/vagrant/test/.vagrant/machines/default/virtualbox/private_key
  IdentitiesOnly yes
  LogLevel FATAL

```

check the connection :

    bundle exec knife ssh 'name:test' -VV "sudo ifconfig" -x vagrant

list the nodes:

    bundle exec knife node list --local-mode

add recipies:

    bundle exec knife node run_list add test 'recipe[python]'

install the cookbook :

    bundle exec knife cookbook site download python
    bundle exec knife cookbook site install python

    bundle exec knife cookbook site download application_python
    bundle exec knife cookbook site install application_python


run converge :

    bundle exec knife zero converge '*:*' --ssh-user vagrant

# setup cookbook

    knife cookbook create zookeepr

put the test-kitchen into the Gemfile and run ```bundle install```

    bundle exec kitchen init

test via vagrant :

    bundle exec kitchen test

this will run on the new vagrant server:
    /opt/chef/bin/chef-solo --config /tmp/kitchen/solo.rb --log_level auto --force-formatter --no-color --json-attributes /tmp/kitchen/dna.json

The  /tmp/kitchen/solo.rb file has these contents :

```

node_name "default-ubuntu-1404"
checksum_path "/tmp/kitchen/checksums"
file_cache_path "/tmp/kitchen/cache"
file_backup_path "/tmp/kitchen/backup"
cookbook_path ["/tmp/kitchen/cookbooks", "/tmp/kitchen/site-cookbooks"]
data_bag_path "/tmp/kitchen/data_bags"
environment_path "/tmp/kitchen/environments"
node_path "/tmp/kitchen/nodes"
role_path "/tmp/kitchen/roles"
client_path "/tmp/kitchen/clients"
user_path "/tmp/kitchen/users"
validation_key "/tmp/kitchen/validation.pem"
client_key "/tmp/kitchen/client.pem"
chef_server_url "http://127.0.0.1:8889"
encrypted_data_bag_secret "/tmp/kitchen/encrypted_data_bag_secret"

```

Inside the /tmp/kitchen/cookbooks

* application
* build-essential
* poise
* poise-python
* python
* yum
* zookeepr
* application_python
* gunicorn
* poise-languages
* poise-service
* supervisor
* yum-epel


# Test the cookbook locally 

in the dir chef/cookbooks/zookeepr

   bundle exec  chef-apply recipes/default.rb  -l debug

# setup berks

in chef/cookbooks/zookeepr

    bundle exec berks init .

# Sources

http://acrmp.github.io/foodcritic/
http://docs.chef.io/
http://docs.chef.io/chef_solo.html
http://docs.chef.io/config_rb_knife_optional_settings.html
http://docs.vagrantup.com/v2/provisioning/chef_solo.html
http://engineering.aweber.com/test-driven-chef-cookbooks-with-test-kitchen/
http://gerhardlazu.com/2010/08/using-chef-to-manage-amazon-ec2-instances-part2/
http://gettingstartedwithchef.com/first-steps-with-chef.html
http://lists.opscode.com/sympa/arc/chef/2014-01/msg00036.html
http://lists.opscode.com/sympa/arc/chef/2014-12/msg00349.html
http://lists.opscode.com/sympa/arc/chef/2014-12/msg00351.html
http://reiddraper.com/first-chef-recipe/
http://scottwb.com/blog/2012/12/13/provision-and-bootstrap-windows-ec2-instances-with-chef/
http://serverfault.com/questions/472848/how-to-configure-knife-and-ec2-to-create-a-new-instance-from-the-command-line
http://serverfault.com/questions/714218/knife-ec2-in-zero-mode-cannot-gives-typeerror-when-ssh-comes-up
http://spin.atomicobject.com/2013/01/03/berks-simplifying-chef-solo-cookbook-management-with-berkshelf/
http://stackoverflow.com/questions/14917640/chef-11-regenerate-validation-key
http://stackoverflow.com/questions/15058483/how-do-you-debug-opscode-chef-ruby-errors
http://stackoverflow.com/questions/15202812/unable-to-create-a-ec2-ubuntu-instance-node-using-chef-and-knife
http://stackoverflow.com/questions/17408816/setting-the-chef-log-level-in-knife-ec2-when-creating-a-server
http://stackoverflow.com/questions/19148995/use-knife-to-create-a-new-recipe-in-a-cookbook#19151619
http://stackoverflow.com/questions/20006584/how-to-use-the-python-lwrp-with-opsworks-chef-11
http://stackoverflow.com/questions/20923546/how-to-set-chef-cookbook-dependencies-in-metadata-file
http://stackoverflow.com/questions/21697438/kitchen-test-how-to-use-local-vm-box
http://stackoverflow.com/questions/23413496/knife-solo-cook-command-not-working-properly
http://stackoverflow.com/questions/31227324/validatorless-bootstraps-in-chef-12-2-0
http://stackoverflow.com/questions/9672458/specifying-which-cookbooks-to-run-with-chef-solo
http://wiki.opscode.com/display/chef/Anatomy+of+a+Chef+Run
http://www.agileweboperations.com/amazon-ec2-instances-with-opscode-chef-using-knife
http://www.forouzani.com/vagrant-chef-tutorial.html
http://www.jasongrimes.org/2012/06/provisioning-a-lamp-stack-with-chef-vagrant-and-ec2-2-of-3/
http://www.sitepoint.com/cooking-with-chef-solo/
http://www.slideshare.net/JulianDunn/cookbook-testing-and-ci-chefboston
https://botbot.me/freenode/chef/2015-07-30/?page=1
https://docs.chef.io/chef_client.html
https://docs.chef.io/chef_private_keys.html
https://docs.chef.io/chef_solo.html
https://docs.chef.io/kitchen.html
https://docs.chef.io/knife_client.html
https://downloads.chef.io/chef-dk/
https://gist.github.com/jbz/1718762
https://github.com/alfredov/django-chef-cookbook
https://github.com/bryanwb/chef-client
https://github.com/chef
https://github.com/chef-cookbooks/database/
https://github.com/chef-cookbooks/iis/
https://github.com/chef/bento
https://github.com/chef/chef
https://github.com/chef/chef-provisioning
https://github.com/chef/chef-provisioning-aws
https://github.com/chef/chef-web-core
https://github.com/chef/chef-zero
https://github.com/chef/dep-selector
https://github.com/chef/dep-selector-libgecode
https://github.com/chef/ffi-yajl
https://github.com/chef/ffi-yajl#yajl-library-packaging
https://github.com/chef/knife-ec2
https://github.com/chef/knife-google
https://github.com/chenjw/knife
https://github.com/fnichol/knife-server/issues/9
https://github.com/higanworks/knife-zero
https://github.com/matschaffer/knife-solo
https://github.com/matschaffer/knife-solo/blob/master/knife-solo.gemspec
https://github.com/matschaffer/knife-solo/blob/master/lib/knife-solo.rb
https://github.com/matschaffer/knife-solo/tree/master/lib
https://github.com/matschaffer/knife-solo/tree/master/lib/knife-solo
https://github.com/matschaffer/knife-solo/tree/master/script
https://github.com/michaelklishin/sous-chef
https://github.com/michaelklishin/sous-chef/blob/master/Vagrantfile.sample
https://github.com/nathenharvey/chef-london-meetup-feb-2015/
https://github.com/necrolyte2/ChefMox
https://github.com/opscode-cookbooks/chef-client
https://github.com/opscode/chef-client
https://github.com/sethvargo/chefspec
https://github.com/stephenlauck/pipeline-example-chef-repo
https://github.com/toast38coza/chef-django
https://s3.amazonaws.com/cloudformation-examples/IntegratingAWSCloudFormationWithOpscodeChef.pdf
https://supermarket.chef.io/cookbooks
https://supermarket.chef.io/cookbooks/application_python
https://supermarket.chef.io/cookbooks/application_python#knife
https://supermarket.chef.io/cookbooks/application_python/follow
https://supermarket.chef.io/cookbooks/aws
https://supermarket.chef.io/cookbooks/django
https://supermarket.chef.io/cookbooks/postgres
https://supermarket.chef.io/cookbooks/python
https://supermarket.chef.io/cookbooks/python#knife
https://supermarket.chef.io/cookbooks/python#librarian
https://supermarket.chef.io/cookbooks/python/download
https://supermarket.chef.io/cookbooks/zeoserver
https://tristandunn.com/2014/12/15/deploying-jekyll-to-vps-part-1/
https://www.chef.io/
https://www.chef.io/blog/2013/10/31/chef-client-z-from-zero-to-chef-in-8-5-seconds/
https://www.chef.io/blog/2015/04/16/validatorless-bootstraps/
https://www.codechef.com/problems/COMPILER
https://www.digitalocean.com/community/tutorials/how-to-create-simple-chef-cookbooks-to-manage-infrastructure-on-ubuntu


https://github.com/h4ck3rm1k3/zookeepr-chef
https://github.com/h4ck3rm1k3/zookeepr-chef-recipe

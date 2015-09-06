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


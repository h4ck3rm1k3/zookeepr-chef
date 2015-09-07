cookbook_path    ["cookbooks", "site-cookbooks"]
node_path        "nodes"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"
client_key       "key.pem"
local_mode true
node_name 'mdupont-Aspire-7750G'

#log_level                :debug
log_location             STDOUT

#encrypted_data_bag_secret "data_bag_key"
#chef_client_path 'chef-client -l debug'

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

#Chef::Config[:ssl_verify_mode] = :verify_peer if defined? ::Chef

#knife[:verbose_commands] 	 
knife[:verbosity] =999

identity_file = 'test.pem'


knife[:automatic_attribute_whitelist] = [
  "fqdn/",
  "ipaddress/",
  "roles/",
]

#cookbook_path    ["cookbooks"]
node_path        "nodes"
node_name        "test"
role_path        "roles"
environment_path "environments"
data_bag_path    "data_bags"


file_cache_path "/mnt/data/home/mdupont/experiments/zookeepr/chef/chef-solo"
cookbook_path  "/mnt/data/home/mdupont/experiments/zookeepr/chef/cookbooks"
no_lazy_load "true"

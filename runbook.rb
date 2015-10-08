# run a cook book.
require 'chef/version'
require 'chef/client'
require 'chef/config'
require 'chef/config_fetcher'
require 'chef/cookbook/file_vendor'
require 'chef/cookbook/file_system_file_vendor'
require 'chef/cookbook_loader'
require 'chef/cookbook/cookbook_collection'
require 'chef/run_context'
require 'rbconfig'
require 'chef/node'
require 'chef/event_dispatch/events_output_stream'
require 'chef/event_dispatch/dispatcher'

Chef::Log.level(:debug)

#cookbook_path="./cookbooks/"
cookbook_path="./cbsources"
cookbook_path2="./cookbooks"

Chef::Cookbook::FileVendor.fetch_from_disk(cookbook_path)
Chef::Cookbook::FileVendor.fetch_from_disk(cookbook_path2)
cl = Chef::CookbookLoader.new(cookbook_path, cookbook_path2)
cl.load_cookbooks

cl.methods.each do |x|
  file,line =  cl.method(x).source_location
  puts "Check #{x}  #{cl.method(x)} File #{file} Line #{line}"
end

puts cl
cookbook_collection = Chef::CookbookCollection.new(cl)
node = Chef::Node.new()
node.default[:runlist] = Chef::RunList.new

node.default['platform'] = "linux",
node.default['platform_version'] = "8.0"

config_fetcher = Chef::ConfigFetcher.new("testnode.json")
json_node_attribs = config_fetcher.fetch_json
#p json_node_attribs

node.consume_attributes(json_node_attribs)
node.expand!("disk")

#p node
codename = node.attribute?('lsb') ? node['lsb']['codename'] : 'notlinux'
print  "#{node['platform'].capitalize} #{codename}"

#require 'cookbooks/apt/attributes/default.rb'
#node.run_list();
events = Chef::EventDispatch::Dispatcher.new()
run_context = Chef::RunContext.new(node, cookbook_collection, events)

recipes = [
  #"recipe[zookeepr]",
  "zookeepr",
]
RunListExpansionIsh = Struct.new(:recipes, :roles)
run_list_expansion_ish =        RunListExpansionIsh.new(recipes, [])
#p "run_context",run_context
#p "run_list_expansion_ish",run_list_expansion_ish

puts "recipes", node[:recipes]

run_context.load(run_list_expansion_ish)
#p "run_context",run_context
runner = Chef::Runner.new(run_context)


  
set_trace_func proc { |event, file, line, id, binding, classname|
#   file.gsub! '/mnt/data/home/mdupont/experiments/zookeepr/chef/cbsources/',"SRC/"
#   file.gsub! '/usr/lib/ruby/2.1.0/',"RUBY/"
  #printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
  printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
}
runner.converge

#require "./cookbooks/zookeepr/recipes/default.rb"
#kmacro-exec-ring-item (quote ([escape 120 99 111 109 112 tab 105 108 tab 101 return return return escape 120 up up up up up] 0 "%d"))

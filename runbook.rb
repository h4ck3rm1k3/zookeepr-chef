# run a cook book.

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

cookbook_path="./cookbooks/"

Chef::Cookbook::FileVendor.fetch_from_disk(cookbook_path)
cl = Chef::CookbookLoader.new(cookbook_path)
cl.load_cookbooks
cookbook_collection = Chef::CookbookCollection.new(cl)
node = Chef::Node.new()
events = Chef::EventDispatch::Dispatcher.new()
run_context = Chef::RunContext.new(node, cookbook_collection, events)
runner = Chef::Runner.new(run_context)

set_trace_func proc { |event, file, line, id, binding, classname|
  file.gsub! '/mnt/data/home/mdupont/experiments/zookeepr/chef/cbsources/',"SRC/"
  file.gsub! '/usr/lib/ruby/2.1.0/',"RUBY/"
     printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
  }
runner.converge

#require "./cookbooks/zookeepr/recipes/default.rb"
#kmacro-exec-ring-item (quote ([escape 120 99 111 109 112 tab 105 108 tab 101 return return return escape 120 up up up up up] 0 "%d"))

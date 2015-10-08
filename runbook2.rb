
require 'chef/recipe'
require 'chef_resource/chef_dsl/chef_recipe'
require 'chef_resource/chef_dsl/resource_definition_dsl'
#puts ChefResource
#puts ChefResource::ChefDSL
#puts ChefResource::ChefDSL::ChefRecipe
#recipe = ChefResource::ChefDSL::ChefRecipe.new(cookbook_name, recipe_name, run_context)

# run a cook book.
require 'chef/client'
require 'chef/config'
require 'chef/config_fetcher'
require 'chef/cookbook/cookbook_collection'
require 'chef/cookbook/file_system_file_vendor'
require 'chef/cookbook/file_vendor'
require 'chef/cookbook_loader'
require 'chef/event_dispatch/dispatcher'
require 'chef/event_dispatch/events_output_stream'
require 'chef/node'
require 'chef/run_context'
require 'chef/version'
require 'chef_resource/chef_dsl/resource_definition_dsl'
require 'rbconfig'
require 'poise_application/resources/application'
require 'chef/resource/execute'
require 'chef/resource/apt_package'
require 'chef/resource/template'
require_relative 'cbsources/database/libraries/resource_postgresql_database_user'

#Chef::Log.level == :debug
Chef::Log.level(:debug)

@cookbook_name = "zookeepr"
recipe_name = "default"
cookbook_path="./cbsources"
cookbook_path2="./cookbooks"

# Chef::Cookbook::FileVendor.fetch_from_disk(cookbook_path)
# Chef::Cookbook::FileVendor.fetch_from_disk(cookbook_path2)
cl = Chef::CookbookLoader.new(cookbook_path, cookbook_path2)
cl.load_cookbooks
# puts cl
cookbook_collection = Chef::CookbookCollection.new(cl)

def create_node 
  mnode = Chef::Node.new()
  mnode.default[:runlist] = Chef::RunList.new
  mnode.default['platform'] = "linux",
  mnode.default['platform_version'] = "8.0"
  puts "new mnode #{mnode}"
  
  #config_fetcher = Chef::ConfigFetcher.new("testnode.json")
  #json_node_attribs = config_fetcher.fetch_json
  json_node_attribs = {
    "name"=>"test",
    "authorization"=>{
      "database"=>{
        "password"=>"funky"}
    },
    "normal"=>{
      "knife_zero"=>{
        "host"=>"test"},
      "tags"=>[]},
    "platform"=>"linux",
    "os_release"=>"8.0",
    "run_list"=>["recipe[zookeepr]"]
  }
  puts "json_node_attribs #{json_node_attribs}"

  mnode.consume_attributes(json_node_attribs)
  #mnode.expand!("disk")
  puts "new mnode #{mnode}"
  
  mnode
end

@mnode = create_node()
puts "get mnode #{@mnode}"
#exit


def node
  puts "get mnode #{@mnode}"
  return @mnode
end


pp node
pp node[:authorization]
pp node[:authorization][:database]
pp node[:authorization][:database][:password]
   
pp node["authorization"]

events = Chef::EventDispatch::Dispatcher.new()
@run_context = Chef::RunContext.new(node, cookbook_collection, events)
@recipe = ChefResource::ChefDSL::ChefRecipe.new(@cookbook_name, recipe_name, @run_context)

def include_recipe(module_name)
end


def declare_resource(name2, callername, block)
  puts "declare_resource( #{name2}, #{callername}, #{block})"
  #@recipe.declare_resource(name2, callername, block)
  raise "declare"

end


#@apt_package = Chef::Provider::Package::Apt.new("apt")

def apt_package(*args, &block)
  res = Chef::Resource::AptPackage.new(args[0]);
  res.instance_eval(&block)
  apt_package = Chef::Provider::Package::Apt.new(res, @run_context)
  apt_package.load_current_resource()
  apt_package.action = :install
  apt_package.action_install(:install)
  return apt_package
end

def execute(*args, &block)
  e= Chef::Resource::Execute.new(args[0])
  e.instance_eval(&block)

  p = Chef::Provider::Execute.new(e, @run_context)
  r2 = p.load_current_resource()
  p.instance_eval(&block)
  p.run_action(:run)
  
  return e 
end


def template(*args, &block)
  #Chef.log_deprecation("Cannot create resource template with more than one argument. All arguments except the name (#{args[0].inspect}) will be ignored. This will cause an error in Chef 13. Arguments: #{args}") if args.size > 1
  #declare_resource(:template, args[0], caller[0], &block)
  r= Chef::Resource::Template.new(args[0])
  r.instance_eval(&block)
  Chef::Log.debug("Resource #{r}")
  pp r
  r.cookbook_name = @cookbook_name	
  p = Chef::Provider::Template.new(r, @run_context)

  #p.cookbook_name = @cookbook_name
  r2 = p.load_current_resource()
  #p.instance_eval(&block)
  Chef::Log.debug("Provider #{p}")
  pp p
  
  p.run_action(:create)
  
  return e   
  
end

             
def application(*args, &block)
  #Chef.log_deprecation("Cannot create resource application with more than one argument. All arguments except the name (#{args[0].inspect}) will be ignored. This will cause an error in Chef 13. Arguments: #{args}") if args.size > 1
  #declare_resource(:application, args[0], caller[0], &block)
  #return @application #PoiseApplication::Resources::Application::Resource.new()
  return PoiseApplication::Resources::Application::Resource.new(args[0])
end


# [2015-10-05T07:10:19-04:00] DEBUG: Loading cookbook database's library file: /mnt/data/home/mdupont/experiments/zookeepr/chef/cbsources/database/libraries/resource_postgresql_database.rb
def postgresql_database(*args, &block)
  #Chef.log_deprecation("Cannot create resource postgresql_database with more than one argument. All arguments except the name (#{args[0].inspect}) will be ignored. This will cause an error in Chef 13. Arguments: #{args}") if args.size > 1
  #declare_resource(:postgresql_database, args[0], caller[0], &block)
end


def postgresql_database_user(*args, &block)
  #Chef.log_deprecation("Cannot create resource postgresql_database_user with more than one argument. All arguments except the name (#{args[0].inspect}) will be ignored. This will cause an error in Chef 13. Arguments: #{args}") if args.size > 1
  #declare_resource(:postgresql_database_user, args[0], caller[0], &block)
  #return @postgresql_database_user
  return Chef::Resource::PostgresqlDatabaseUser.new(args[0])
end

require_relative './cbsources/postgresql/libraries/default'

#require_relative './cbsources/application/lib/poise_application/resources/application'
# set_trace_func proc { |event, file, line, id, binding, classname|
# #   file.gsub! '/mnt/data/home/mdupont/experiments/zookeepr/chef/cbsources/',"SRC/"
# #   file.gsub! '/usr/lib/ruby/2.1.0/',"RUBY/"
#   #printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
#   printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
# }

require_relative './cookbooks/zookeepr/recipes/default'

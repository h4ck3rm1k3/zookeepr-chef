require 'chef/node'

#Chef::Log.level == :debug
Chef::Log.level(:debug)
#set_trace_func proc { |event, file, line, id, binding, classname|
#  printf "%8s %s:%-2d %10s %8s\n", event, file, line, id, classname
#}
 
#   # if (!classname.nil?) 
#   #   #pp classname
#   #   pp classname.instance_method(id).source_location
#   # end


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
  ##pp mnode
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
pp node['authorization']

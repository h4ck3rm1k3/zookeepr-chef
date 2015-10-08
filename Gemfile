# A sample Gemfile
source "https://rubygems.org"

def dogem(name, version=">0.0.0", path: File.join('./cbsources', name))
  #path2 = File.expand_path(path, __FILE__)
  #path2 = File.expand_path(File.join('..', path), __FILE__)
  #puts path, path2, name, version
  if File.exist?(path)
    #puts "Found #{name} in #{path}"
    gem name, path: path
  elsif
    puts "Did not find #{name} in #{path}"
    gem name, version
  end
end



                                                                                      
#bundle config build.nokogiri --use-system-libraries
#gem "bundler",:path => 'cbsources/bundler'  apt-get install bundler
dogem "CFPropertyList","2.3.1"
dogem "addressable","2.3.8"
dogem "aws-sdk","2.1.17"
dogem "aws-sdk-resources","2.1.17"
dogem "aws-sdk-v1","1.65.0"
dogem "berkshelf", :path => 'cbsources/berkshelf'
dogem "berkshelf-api-client","1.3.0"
dogem "buff-config", :path => 'cbsources/buff-config'
dogem "buff-extensions","1.0.0"
dogem "buff-ignore","1.1.1"
dogem "buff-ruby_engine","0.1.0"
dogem "buff-shell_out","0.2.0"
dogem "builder","3.2.2"
dogem "celluloid","0.16.0"
dogem "celluloid-io","0.16.2"
dogem "chef", :path => 'cbsources/chef'
dogem "chef-config", :path => 'cbsources/chef/chef-config'
dogem "chef-provisioning",:path => 'cbsources/chef-provisioning'
dogem "chef-provisioning-aws", :path => 'cbsources/chef-provisioning-aws'
dogem "chef-zero",:path => 'cbsources/chef-zero'
dogem "cheffish","1.3.1"
dogem "childprocess","0.5.6"
dogem "cleanroom","1.0.0"
dogem "coderay","1.1.0"
dogem "coveralls","0.8.2"
dogem "dep-selector-libgecode",  :path => 'cbsources/dep-selector-libgecode'
dogem "dep_selector",  :path => 'cbsources/dep-selector'
dogem "diff-lcs","1.2.5"
dogem "docile","1.1.5"
dogem "domain_name","0.5.24"
dogem "em-winrm","0.7.0"
dogem "erubis","2.7.0"
dogem "eventmachine","1.0.8"
dogem "excon","0.45.4"
dogem "faraday","0.9.1"
dogem "ffi", :path => 'cbsources/ffi'
dogem "ffi-yajl", :path => 'cbsources/ffi-yajl'
dogem "fission","0.5.0"
dogem "fog-aws","0.7.6"
dogem "formatador","0.2.5"
dogem "gssapi","1.2.0"
dogem "gyoku","1.3.1"
dogem "hashie","2.1.2"
dogem "highline","1.7.3"
dogem "hitimes","1.2.2"
dogem "http-cookie","1.0.2"
dogem "httpclient","2.6.0.1"
dogem "i18n","0.7.0"
dogem "inflecto","0.0.2"
dogem "inifile","2.0.2"
dogem "ipaddress","0.8.0"
dogem "json","1.8.1" # from apt-get install ruby-json
dogem "kitchen-vagrant", :path => 'cbsources/kitchen-vagrant'
dogem "knife-ec2" #,"0.11.0"
dogem "knife-solo", :path => 'cbsources/knife-solo'
dogem "knife-windows","0.8.6"
dogem "knife-zero",:path => 'cbsources/knife-zero'
dogem "librarian","0.1.2"
dogem "librarian-chef","0.0.4"
dogem "libyajl2","1.2.0"
dogem "little-plugger","1.1.4"
dogem "logging", "1.8.1"
dogem "metaclass","0.0.4"
dogem "method_source","0.8.2"
dogem "mime-types","2.6.1"
dogem "minitar","0.5.4"
dogem "minitest","4.7.5"
dogem "mixlib-authentication","1.3.0"
dogem "mixlib-cli","1.5.0"
dogem "mixlib-config", :path => 'cbsources/mixlib-config'
dogem "mixlib-install","0.7.0"
dogem "mixlib-log","1.6.0"
dogem "mocha","1.1.0"
dogem "multipart-post","2.0.0"
dogem "net-http-persistent","2.9.4"
dogem "net-scp","1.2.1"
dogem "net-ssh","2.9.2"
dogem "net-ssh-gateway","1.2.0"
dogem "net-ssh-multi","1.2.1"
dogem "net-telnet","0.1.1"
dogem "netrc","0.10.3"
dogem "nio4r","1.1.1"
dogem "nokogiri",">0.0.0" # from apt-get install ruby-nokogiri
dogem "nori","2.6.0"
dogem "octokit","3.8.0"
dogem "ohai", :path => 'cbsources/ohai'
dogem "parallel","1.6.1"
dogem "plist","3.1.0"
dogem "pry","0.10.1"
dogem "rack","1.6.4"
dogem "rake","10.4.2"
dogem "rb-fsevent", "0.9.6"
dogem "rdoc","4.2.0"
dogem "rest-client","1.8.0"
dogem "retryable","2.0.2"
dogem "ridley"
dogem "rspec","3.3.0"
dogem "rspec-core", :path => 'cbsources/rspec-core'
dogem "rspec-expectations", :path => 'cbsources/rspec-expectations'
dogem "rspec-its","1.2.0"
dogem "rspec-mocks", :path => 'cbsources/rspec-mocks'
dogem "rspec-support","3.3.0"
dogem "rspec_junit_formatter","0.2.3"
dogem "rubyntlm","0.4.0"
dogem "sawyer","0.6.0"
dogem "sdoc","0.4.1"
dogem "semverse","1.2.1"
dogem "serverspec","~> 2.7"
dogem "sfl","2.2"
dogem "simplecov","0.10.0"
dogem "simplecov-html","0.10.0"
dogem "solve","1.2.1"
dogem "specinfra","2.42.2"
dogem "syslog-logger","1.6.8"
dogem "systemu","2.6.5"
dogem "term-ansicolor","1.3.2"
dogem "test-kitchen"
dogem "thor","0.19.1"
dogem "timers","4.0.1"
dogem "tins","1.6.0"
dogem "ubuntu_ami","0.4.1"
dogem "unf","0.1.4"
dogem "unf_ext","0.0.7.1"
dogem "uuidtools","2.1.5"
dogem "vagrant", :path => 'cbsources/vagrant'
dogem "varia_model","0.4.0"
dogem "winrm","1.3.4"
dogem "winrm-s","0.3.1"
dogem "wmi-lite","1.0.0"
dogem 'chefspec', :path => 'cbsources/chefspec'
dogem 'knife-reporting'
dogem 'knife-spec', :path => 'cbsources/knife-spec'
dogem 'knife-vagrant2'
dogem 'poise', :path => 'cbsources/poise'
dogem 'poise-application', :path => 'cbsources/application'
dogem 'poise-python', :path => 'cbsources/poise-python'
dogem 'poise-application-git', :path => 'cbsources/application_git'
dogem 'poise-application-python', :path => 'cbsources/application_python'
dogem 'poise-service', :path => 'cbsources/poise-service'
dogem 'pry-rescue'
dogem 'pry-stack_explorer'
dogem 'chef-resource', :path => 'cbsources/resource'


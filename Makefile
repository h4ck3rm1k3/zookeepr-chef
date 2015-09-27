
doit :
#	git submodule init
#	git submodule update
	bundle install
	#bundle exec berks install
	bundle exec rake2.1 build


#run_test:
#	strace -e open -f -o trace.txt bundle exec chef-solo --config test_files/solo.rb  --json-attributes test_files/dna.json

run_solo :
	bundle exec chef-solo -c solo.rb  -j nodes/test.json --log_level debug --force-formatter --no-color

bundlerinstall:
	bundle install

bootstrap :

	#strace -f -o test.log
	bundle exec knife bootstrap -z 192.168.67.2 --ssh-user vagrant  --local-mode --no-color --sudo 
	#	--verbose --verbose	


zboot :
	bundle exec knife zero bootstrap 192.168.67.2 --ssh-user vagrant --sudo  --no-color


converge :
	bundle exec knife zero converge 'name:test' -a fqdn --ssh-user vagrant --sudo --no-color --sudo 

upload_all:
	bundle exec  knife cookbook upload -a

runbundle:
	bundle install  --path gempath/

setup_cookbooks:
	bundle exec knife cookbook site download python
	bundle exec knife cookbook site install python

	bundle exec knife cookbook site download poise
	bundle exec knife cookbook site install poise

	bundle exec knife cookbook site download application_python
	bundle exec knife cookbook site install application_python

	bundle exec knife cookbook site download poise
	bundle exec knife cookbook site install poise

	bundle exec knife cookbook site download application # we need to overwrite this later
	bundle exec knife cookbook site install application

	bundle exec knife cookbook site download poise-service
	bundle exec knife cookbook site install poise-service

	bundle exec knife cookbook site download poise-python
	bundle exec knife cookbook site install poise-python

	bundle exec knife cookbook site download poise-languages
	bundle exec knife cookbook site install poise-languages

	bundle exec knife cookbook site download postgres
	bundle exec knife cookbook site install postgres

	bundle exec knife cookbook site download git
	bundle exec knife cookbook site install git

	bundle exec knife cookbook site download database
	bundle exec knife cookbook site install database

	bundle exec knife cookbook site download postgres
	bundle exec knife cookbook site install postgres

	bundle exec knife cookbook site download openssl
	bundle exec knife cookbook site install openssl

setup_cookbooks2:

	#bundle exec knife cookbook site download poise-application-git
	#bundle exec knife cookbook site install poise-application-git
	#bundle exec knife cookbook site download application_git
	bundle exec knife cookbook site install application_git


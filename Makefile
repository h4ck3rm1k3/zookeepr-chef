
bootstrap :

	#strace -f -o test.log
	bundle exec knife bootstrap -z 192.168.67.2 --ssh-user vagrant  --local-mode --no-color --sudo 
	#	--verbose --verbose	


zboot :
	bundle exec knife zero bootstrap 192.168.67.2 --ssh-user vagrant --sudo  --no-color


converge :
	bundle exec knife zero converge 'name:test' -a fqdn --ssh-user vagrant --sudo

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

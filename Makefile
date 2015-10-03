cbsources/bundler/bundler-1.10.6.gem :
	cd cbsources/bundler/ && gem build bundler.gemspec
	gem install cbsources/bundler/*.gem

prepare :cbsources/bundler/bundler-1.10.6.gem
	cd cbsources/application && bundle exec rake package

install :
	apt-get install	ruby-json

run_book :
	bundle exec ruby ./runbook.rb

# test locally and fast
run_solo :
	bundle exec chef-solo -c solo.rb  -j nodes/test.json --log_level debug --force-formatter --no-color

bundle_install:
	bundle install

bootstrap :

	bundle exec knife bootstrap -z 192.168.67.2 --ssh-user vagrant  --local-mode --no-color --sudo 

zbootstrap :
	bundle exec knife zero bootstrap 192.168.67.2 --ssh-user vagrant --sudo  --no-color

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


# knife cookbook bulk delete REGEX (options)
# knife cookbook create COOKBOOK (options)
# knife cookbook delete COOKBOOK VERSION (options)
# knife cookbook download COOKBOOK [VERSION] (options)
# knife cookbook list (options)
# knife cookbook metadata COOKBOOK (options)
# knife cookbook metadata from FILE (options)
# knife cookbook show COOKBOOK [VERSION] [PART] [FILENAME] (options)
# knife cookbook test [COOKBOOKS...] (options)
# knife cookbook upload [COOKBOOKS...] (options)


upload_all:
	bundle exec  knife cookbook upload -a

converge :
	bundle exec knife zero converge 'name:test' -a fqdn --ssh-user vagrant --sudo --no-color --sudo  --verbose --verbose  -c knifezero.rb

converge_poise :
	bundle exec knife zero converge 'name:test' -a fqdn --ssh-user vagrant --sudo --no-color --sudo  --verbose --verbose  -c knifezero.rb -o poise


upload_poise:
	strace -e open  -o upload.txt -f bundle exec  knife cookbook upload poise 2.4.1.pre

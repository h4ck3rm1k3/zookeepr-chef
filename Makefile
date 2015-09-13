
bootstrap :

	#strace -f -o test.log
	bundle exec knife bootstrap -z 192.168.67.2 --ssh-user vagrant  --local-mode --no-color --sudo 
	#	--verbose --verbose	


zboot :
	bundle exec knife zero bootstrap 192.168.67.2 --ssh-user vagrant --sudo  --no-color


converge :
	bundle exec knife zero converge '*:*' --ssh-user vagrant 

runbundle:
	bundle install  --path gempath/

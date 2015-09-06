#DEBUG=1
#EXCON_DEBUG=1
#export KNIFE_CLIENT_KEY=key

bundler exec knife ec2 server create  --local-mode --verbose --verbose 

#--aws-credential-file /home/mdupont/.aws/credentials

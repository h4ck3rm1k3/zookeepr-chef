#Instructions

1. create key named ``test`` in aws store in zookeepr/chef/.chef/test.pem
2. ssh-add the key to the ssh agent
3. setup your ~/.ssh/config like this 

    Host ec2*compute-1.amazonaws.com
      StrictHostKeyChecking no
      User admin
      IdentityFile  /mnt/data/home/mdupont/experiments/zookeepr/chef/.chef/test.pem


see
http://gerhardlazu.com/2010/08/using-chef-to-manage-amazon-ec2-instances-part2/
http://scottwb.com/blog/2012/12/13/provision-and-bootstrap-windows-ec2-instances-with-chef/

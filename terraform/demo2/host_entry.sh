#!/bin/bash
master="$(terraform output master_privip)"
worker1="$(terraform output worker1_privip)"
worker2="$(terraform output worker2_privip)"
controller_pubIP="$(terraform output controller_pubip)"
controller_pubdns="$(terraform output controller_pubdns)"
echo  -e "[managernode]\n$master\n[workernode]\n$worker1\n$worker2\n[all:vars]\nmanager_ip=$master" > /home/ubuntu/docker_swarm_cluster_aws/ansible/inventoryfile
cat /home/ubuntu/ansible/inventoryfile
Priv_key_path=~/.ssh/awstesting.pem
echo -e "Host 10.0.*.* \n\tIdentityFile $Priv_key_path\n\tProxyCommand ssh -W %h:%p $controller_pubdns\n\tCheckHostIP no\n\tStrictHostKeyChecking no" > /home/ubuntu/docker_swarm_cluster_aws/ansible/ssh.cfg
echo -e "Host $controller_pubdns\n\tHostname $controller_pubdns\n\tUser ubuntu\n\tControlMaster auto\n\tControlPath ~/.ssh/ansible-%r@%h:%p\n\tControlPersist 3m\n\tIdentityFile $Priv_key_path\n\tCheckHostIP no\n\tStrictHostKeyChecking no" >> /home/ubuntu/docker_swarm_cluster_aws/ansible/ssh.cfg

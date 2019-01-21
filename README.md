# dockerswarm_aws
=>download and configure terraform https://learn.hashicorp.com/terraform/getting-started/install.html by this link.

=>configuration of docker swarm in aws with terraform and ansible.

=>you have to get the access key and secret key of aws user with yourself and put it in terraform.tfvars files.

=>configure aws cli on you machine--this is required to configure terraform backend configuration on s3 bucker.Please create a bucket in s3 manually and provide bucket name in backend.tf file.

=>You can make changes in terraform files for the region and which ami you are going to use.

=>You have to generate your key pair and copy it .ssh path(or if u are generating or saving your key in different path then you have to put this path in terraform.tfvars file).

=>Run terraform apply

=>Put aws key pair(pem file) in the path you want and start ssh-agent and provide this path of the pem file.

=>Run host_entry.sh to create inventory file and ssh.cfg(ensure the path in the script exist) file for ssh-agent to work.

=>Make changes in /etc/ansible/ansible.cfg in [ssh_connection] ssh_args = -F <path of ssh.cfg file>.

=>Now run the ansible play book file. ansible-playbook -i inventory main.yml and your docker swarm will be configured and one application will be running. you can access this app by hitting in browser of url <ip of master node:8080> .
Bang on.

resource "aws_security_group" "swarm_master"{
	vpc_id = "${aws_vpc.docker_swarm.id}"
	name = "allow_ssh_manager"
	description = "security group that allow ssh and all egress traffic"
	egress {
		from_port = 0
		to_port = 0
		protocol = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
	ingress {
		from_port = 0
		to_port = 0 
		protocol = "-1"
		cidr_blocks = ["114.143.194.190/32"]
	}
        ingress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["115.113.153.34/32"]
        }

        ingress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["10.0.0.0/16"]
        }

/*	ingress {
		from_port = 22
		to_port = 22
		protocol = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}*/
	tags {
                Name = "swarm_master"
        }
}
/*resource "aws_security_group" "swarm_worker"{
        vpc_id = "${aws_vpc.docker_swarm.id}"
        name = "allow-ssh_worker"
        description = "security group that allow ssh from my local pc and communication with master"

	ingress {
        	from_port = 0
        	to_port = 0
        	protocol = "-1"
        	cidr_blocks = ["114.143.194.190/32"]
        }
	 ingress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["115.113.153.34/32"]
        }
	ingress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["10.0.0.0/16"]
        }
	egress {
                from_port = 0
                to_port = 0
                protocol = "-1"
                cidr_blocks = ["0.0.0.0/0"]
        }

	tags {
		Name = "swarm_worker"
	}
}*/

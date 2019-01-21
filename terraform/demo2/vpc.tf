#Internet Vpc
resource "aws_vpc" "docker_swarm" {
	cidr_block = "10.0.0.0/16"
	instance_tenancy = "default"
	enable_dns_support = "true"
	enable_dns_hostnames = "true"
	enable_classiclink = "false"
	tags {
		Name = "docker_swarm"
	}
}
#elastic ip
resource "aws_eip" "cluster_eip" {
    vpc = true
    depends_on = ["aws_internet_gateway.main-gw"]
    tags {
        Name = "Elastic_ip"
    }
}


#Internet GW
resource "aws_internet_gateway" "main-gw" {
	vpc_id = "${aws_vpc.docker_swarm.id}"
	tags {
		Name = "docker_swarm"
	}
}

#Nat Gateway
resource "aws_nat_gateway" "nat_gateway" {
    allocation_id = "${aws_eip.cluster_eip.id}"
    subnet_id = "${aws_subnet.master_public.id}"
    depends_on = ["aws_internet_gateway.main-gw"]
}

#public subnets
resource "aws_subnet" "master_public" {
        vpc_id = "${aws_vpc.docker_swarm.id}"
        cidr_block = "10.0.1.0/24"
        map_public_ip_on_launch = "true"
        availability_zone = "us-west-1a"
        tags {
                Name = "master_public"
        }
}


#Routetables for public subnet
resource "aws_route_table" "master_public_routeIGW" {
	vpc_id = "${aws_vpc.docker_swarm.id}"
	route {
		cidr_block = "0.0.0.0/0"
		gateway_id = "${aws_internet_gateway.main-gw.id}"
		}
	tags {
		Name = "master_public"
	}
}

#route association public subnet with IGW
resource "aws_route_table_association" "master_public_route"{
	subnet_id = "${aws_subnet.master_public.id}"
	route_table_id = "${aws_route_table.master_public_routeIGW.id}"

}

#private subnet
resource "aws_subnet" "worker_private" {
        vpc_id = "${aws_vpc.docker_swarm.id}"
        cidr_block = "10.0.2.0/24"
        map_public_ip_on_launch = "false"
        availability_zone = "us-west-1a"
        tags {
                Name = "worker_private"
        }
}


#routetable for private subnet
resource "aws_route_table" "worker_private_NATGW" {
        vpc_id = "${aws_vpc.docker_swarm.id}"
        route {
                cidr_block = "0.0.0.0/0"
                nat_gateway_id = "${aws_nat_gateway.nat_gateway.id}"
                }
        tags {
                Name = "worker_private_NAT"
        }
}
#route association privatesubnet with natgateway
resource "aws_route_table_association" "worker_private_route"{
        subnet_id = "${aws_subnet.worker_private.id}"
        route_table_id = "${aws_route_table.worker_private_NATGW.id}"

}


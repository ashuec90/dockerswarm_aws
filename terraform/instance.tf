resource "aws_key_pair" "mykey"{
 key_name = "id_rsa.pub"
 public_key = "${file("${var.PATH_TO_PUBLIC_KEY}")}"
}
#master node 
resource "aws_instance" "master" {
        ami  		  = "${lookup(var.AMIS, var.AWS_REGION)}"
        instance_type = "t2.micro"
	#the vpc subnet
	subnet_id = "${aws_subnet.master_public.id}"
	
	#the security group
	vpc_security_group_ids = ["${aws_security_group.swarm_master.id}"]
		
	#the public SSH key
	 key_name      = "${aws_key_pair.mykey.key_name}"
		
/*#print the public ip in the output after creation		
	provisioner "file"{
                source = "script.sh"
                destination = "/home/ubuntu/script.sh"
		}
        connection{
                        user = "${var.INSTANCE_USERNAME}"
                        private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
                  }
        provisioner "remote-exec" {
                inline = [
                        "chmod +x /home/ubuntu/script.sh",
                        "/home/ubuntu/script.sh"
                        ]
                }
		provisioner "local-exec" {
				command = "echo ${aws_instance.master.private_ip} >> private_ip.txt"
				}*/

}

resource "aws_instance" "worker1" {
        ami  		  = "${lookup(var.AMIS, var.AWS_REGION)}"
        instance_type = "t2.micro"
	#the vpc subnet
	subnet_id = "${aws_subnet.worker_private.id}"
	#subnet_id = "${aws_subnet.master_public.id}"

	#the security group
	vpc_security_group_ids = ["${aws_security_group.swarm_master.id}"]
		
	#the public SSH key
        key_name      = "${aws_key_pair.mykey.key_name}"
/*        provisioner "file"{
                source = "script.sh"
                destination = "/home/ubuntu/script.sh"
                }
        connection{
                        user = "${var.INSTANCE_USERNAME}"
                        private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
                  }
        provisioner "remote-exec" {
                inline = [
                        "chmod +x /home/ubuntu/script.sh",
                        "/home/ubuntu/script.sh"
                        ]
                }*/

}
resource "aws_instance" "worker2" {
        ami               = "${lookup(var.AMIS, var.AWS_REGION)}"
        instance_type = "t2.micro"
        #the vpc subnet
        subnet_id = "${aws_subnet.worker_private.id}"
        #subnet_id = "${aws_subnet.master_public.id}"

        #the security group
        vpc_security_group_ids = ["${aws_security_group.swarm_master.id}"]

        #the public SSH key
        key_name      = "${aws_key_pair.mykey.key_name}"

/*        provisioner "file"{
                source = "script.sh"
                destination = "/home/ubuntu/script.sh"
                }
        connection{
                        user = "${var.INSTANCE_USERNAME}"
                        private_key = "${file("${var.PATH_TO_PRIVATE_KEY}")}"
                  }
        provisioner "remote-exec" {
                inline = [
                        "chmod +x /home/ubuntu/script.sh",
                        "/home/ubuntu/script.sh"
                        ]
                }*/

}
	

resource "aws_instance" "controller" {
        ami               = "${lookup(var.AMIS, var.AWS_REGION)}"
        instance_type = "t2.micro"
        #the vpc subnet
        #subnet_id = "${aws_subnet.worker_private.id}"
        subnet_id = "${aws_subnet.master_public.id}"
        
	#the security group
        vpc_security_group_ids = ["${aws_security_group.swarm_master.id}"]

        #the public SSH key
        key_name      = "${aws_key_pair.mykey.key_name}"
        }


output "master_pubip" {
	value = "${aws_instance.master.public_ip}"
}
output "worker1_privip" {	
	value = "${aws_instance.worker1.private_ip}"
}
output "worker2_privip" {
	value = "${aws_instance.worker2.private_ip}"
	}
output "master_privip" {
        value = "${aws_instance.master.private_ip}"
}
output "controller_pubip" {
        value = "${aws_instance.controller.public_ip}"
}
output "controller_privip" {
        value = "${aws_instance.controller.private_ip}"
}
output "controller_pubdns" {
        value = "${aws_instance.controller.public_dns}"
}


provider "aws" {
    region = "ap-south-1"
}

variable "cidr-range" {
    default = "10.0.0.0/16"
}
variable "cidr-sub" {
    default = "10.0.0.0/24"
}
variable "cidr-subpvt" {
    default = "10.0.1.0/24"
}
variable "ec2-ami" {
    description = "Ami for Ec2 instance"
    type = string
    default = "ami-0199ac7c9fbf9ed83"
}

variable "inst-type"{
    description = "Instance type for ec2"
    type = string
    default = "t3.micro"
}

variable "inst-name"{
    description = "Name of the instance"
    type = string
    default = "Controller"
}
resource "aws_key_pair" "keypair1" {
    key_name = "terraform-key"
    public_key = file("~/.ssh/id_rsa.pub")
}
resource "aws_vpc" "MYVPC" {
    cidr_block = var.cidr-range
}
resource "aws_subnet" "pubsub" {
    vpc_id = aws_vpc.MYVPC.id
    cidr_block = var.cidr-sub
    availability_zone = "ap-south-1a"
    map_public_ip_on_launch = true
    tags = {
        Name = "Public-Subnet"
    }
}
resource "aws_subnet" "pvtsub" {
    vpc_id = aws_vpc.MYVPC.id
    cidr_block = var.cidr-subpvt
    availability_zone = "ap-south-1b"
    map_public_ip_on_launch = false
    tags = {
        Name = "Private-Subnet"
    }
}
resource "aws_internet_gateway" "igw"{
    vpc_id = aws_vpc.MYVPC.id
    tags = {
        Name = "IGW"
    }
}
resource "aws_eip" "nat-eip"{
    domain = "vpc"
    tags = {
        Name = "EIP"
    }
}
resource "aws_nat_gateway" "nat-gate"{
    allocation_id = aws_eip.nat-eip.id
    subnet_id = aws_subnet.pubsub.id
    tags = {
        Name = "NGW"
    }
    depends_on = [aws_internet_gateway.igw]
}
resource "aws_route_table" "rt-pub" {
    vpc_id = aws_vpc.MYVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }
    tags = {
        Name = "public-route-table"
  }
}
resource "aws_route_table_association" "rta-pub"{
    subnet_id = aws_subnet.pubsub.id
    route_table_id = aws_route_table.rt-pub.id
}
resource "aws_route_table" "rt-pvt" {
    vpc_id = aws_vpc.MYVPC.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_nat_gateway.nat-gate.id
    }
    tags = {
       Name = "private-route-table"
  }
}
resource "aws_route_table_association" "rta-pvt"{
    subnet_id = aws_subnet.pvtsub.id
    route_table_id = aws_route_table.rt-pvt.id
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound"
  vpc_id = aws_vpc.MYVPC.id

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]  
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_instance" "master" {
  ami                         = var.ec2-ami
  instance_type                = var.inst-type
  associate_public_ip_address  = true
  vpc_security_group_ids       = [aws_security_group.allow_ssh.id]
  subnet_id = aws_subnet.pubsub.id
  tags = {
    Name = var.inst-name
  }
 
  connection {
    type = "ssh"
    host = self.public_ip
    user = "ubuntu"
    private_key = file("~/.ssh/id_rsa")
  }
  provisioner "file" {
    source = "webpage.html"
    destination = "/home/ubuntu/index.html"
}
}
output "vpc_id" {
    value = aws_vpc.MYVPC.id

}

output "public-ip" {
    value = aws_instance.master.public_ip
  
}
output "inst-id"{
    value = aws_instance.master.id
}



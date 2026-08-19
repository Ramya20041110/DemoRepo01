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

output "vpc_id" {
    value = aws_vpc.MYVPC.id

}

output "public-ip" {
    value = aws_instance.master.public_ip
  
}
output "inst-id"{
    value = aws_instance.master.id
}

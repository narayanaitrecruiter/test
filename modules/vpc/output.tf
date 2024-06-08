output "vpc_id" {
  value = aws_vpc.non_prod_vpc.id    
  
}

output "subnet_ids" {
  value = [aws_subnet.PublicSubnet1.id, aws_subnet.PublicSubnet2.id, aws_subnet.PublicSubnet3.id]
  
}
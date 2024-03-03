resource "aws_instance" "EC2-1" {
  ami           = var.ami_id
  instance_type = var.instance_type
  subnet_id = aws_subnet.zoeencloud-private-1.id 
  security_groups = [aws_security_group.EC2_SG.id]
  tags = {
    Name = "EC2-1"
  }
}

resource "aws_ec2_instance_connect_endpoint" "ec2_connect" {
  subnet_id = aws_subnet.zoeencloud-private-1.id 
}
resource "aws_security_group" "EC2_SG"{
    name = "EC2_Security_Group"
    description = "To allow SSH connection"
    vpc_id = aws_vpc.zoeencloud.id

 ingress {
     from_port   = 22
     to_port     = 22
     protocol    = "tcp"
     cidr_blocks = ["0.0.0.0/0"]
    } 
 egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1" # for allowing all protocols
    cidr_blocks = ["0.0.0.0/0"]
  }
 tags = {
    Name = "EC2_SG"
  }
}

#RDS_SG

resource "aws_security_group" "RDS_SG"{
    name = "RDS_Security_Group"
    description = "To allow MySQL connection"
    vpc_id = aws_vpc.zoeencloud.id

 ingress {
    from_port = 3306
    to_port = 3306
    protocol = "tcp"
    cidr_blocks = ["10.0.0.0/16"]
 }

 egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
 }

 tags = {
    Name = "RDS_SG"
}
}


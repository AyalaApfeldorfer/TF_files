resource "aws_redshift_cluster" "my_redshift_cluster" {
  publicly_accessible    = true
  port = "3306"
  vpc_security_group_ids = [aws_security_group.my_vpc_security_group.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.my_redshift_subnet_group
}

resource "aws_redshift_cluster" "my_redshift_cluster1" {
  publicly_accessible    = true
  port = "3306"
  vpc_security_group_ids = [aws_security_group.my_vpc_security_group.id]
  cluster_subnet_group_name = aws_redshift_subnet_group.my_redshift_subnet_group
}

resource "aws_security_group" "my_vpc_security_group" {
  name        = "my_vpc_security_group"
  id = "sg-12345678"

  ingress {
    description      = "TLS from VPC"
    from_port        = 3305
    to_port          = 3307
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}

resource "aws_redshift_subnet_group" "my_redshift_subnet_group" {
  name       = "my_redshift_subnet_group"
  subnet_ids = [aws_subnet.my_subnet.id]
}


resource "aws_subnet" "my_subnet" {
    vpc_id     = aws_vpc.my_vpc.id
}

resource "aws_route_table_association" "my_route_table_association" {
  subnet_id      = aws_subnet.my_subnet.id
  route_table_id = aws_route_table.my_route_table.id
}

resource "aws_route_table" "my_route_table" {
  vpc_id     = aws_vpc.my_vpc2.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-"
  }

}

resource "aws_vpc" "my_vpc" {

}


resource "aws_vpc" "my_vpc2" {

}


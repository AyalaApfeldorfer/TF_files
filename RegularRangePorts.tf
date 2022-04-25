resource "aws_instance" "nnoo" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = "1.1.11.1"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  security_groups = [aws_security_group.exposed_SG_range2]


  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "exposed_SG_range2" {
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"

  ingress {
    description = "TLS from VPC"
    cidr_blocks = "0.0.0.0/0"
    from_port = 45
    to_port = 55
    protocol = "TCP"
  }

}


resource "aws_route_table" "example2" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = "igw-1111"
  }

  tags = {
    Name = "example"
  }
}

resource "aws_instance" "ggoo" {
  ami           = "ami-005e54dee72cc1000" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = "1.1.11.1"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  security_groups = [aws_security_group.exposed_SG_1regular2]


  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "exposed_SG_1regular2" {
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"

  ingress {
    description = "TLS from VPC"
    cidr_blocks = "0.0.0.0/0"
    from_port = 19
    to_port = 19
    protocol = "TCP"
  }

}
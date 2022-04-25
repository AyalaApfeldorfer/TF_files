resource "aws_vpc" "my_vpc" {
  cidr_block = "172.16.0.0/16"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.my_vpc.id
  cidr_block        = "172.16.10.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-example"
  }
}

resource "aws_network_interface" "foo" {
  subnet_id   = aws_subnet.my_subnet.id
  private_ips = ["172.16.10.100"]

  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_instance" "roo" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = "1.1.11.1"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  security_groups = [aws_security_group.exposed_SG_rdp]


  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "exposed_SG_rdp" {
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"

  ingress {
    description = "TLS from VPC"
    cidr_blocks = "0.0.0.0/0"
    from_port = 3389
    to_port = 3389
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

resource "aws_instance" "soo" {
  ami           = "ami-005e54dee72cc1000" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = "1.1.11.1"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  security_groups = [aws_security_group.exposed_SG_22]


  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "exposed_SG_22" {
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"

  ingress {
    description = "TLS from VPC"
    cidr_blocks = "0.0.0.0/0"
    from_port = 22
    to_port = 22
    protocol = "TCP"
  }

}

resource "aws_instance" "noo" {
  ami           = "ami-005e54dee72cc1d00" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = "1.1.11.1"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  security_groups = [aws_security_group.exposed_SG_range]


  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "exposed_SG_range" {
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"

  ingress {
    description = "TLS from VPC"
    cidr_blocks = "0.0.0.0/0"
    from_port = 33
    to_port = 44
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

resource "aws_instance" "goo" {
  ami           = "ami-005e54dee72cc1000" # us-west-2
  instance_type = "t2.micro"
  associate_public_ip_address = "1.1.11.1"
  network_interface {
    network_interface_id = aws_network_interface.foo.id
    device_index         = 0
  }
  security_groups = [aws_security_group.exposed_SG_1regular]


  credit_specification {
    cpu_credits = "unlimited"
  }
}

resource "aws_security_group" "exposed_SG_1regular" {
  description = "Allow inbound traffic to ElasticSearch from VPC CIDR"

  ingress {
    description = "TLS from VPC"
    cidr_blocks = "0.0.0.0/0"
    from_port = 20
    to_port = 20
    protocol = "TCP"
  }

}
resource "aws_db_instance" "my_rds" {
  publicly_accessible    = true
  port = "3305"
  engine = "mysql"
  vpc_security_group_ids = [aws_security_group.my_vpc_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group
}

resource "aws_db_instance" "my_rds2" {
  publicly_accessible    = true
  port = "3306"
  engine = "mysql"
  vpc_security_group_ids = [aws_security_group.my_vpc_security_group.id]
  db_subnet_group_name = aws_db_subnet_group.my_db_subnet_group
}

resource "aws_db_security_group" "my_db_security_group" {
  name = "my_db_security_group"

  ingress {
    cidr = "0.0.0.0/0"
  }
}

resource "aws_security_group" "my_vpc_security_group" {
  name        = "my_vpc_security_group"
  id = "sg-12345678"

  ingress {
    description      = "TLS from VPC"
    from_port        = 3300
    to_port          = 3307
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

}
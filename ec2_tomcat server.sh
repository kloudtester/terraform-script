provider "aws" {
    region  = "ap-south-1"
}

resource "aws_instance" "tomcat" {
  ami           = "ami-05c8ca4485f8b138a"
  instance_type = "t2.micro"
  key_name      = "krishna"

  user_data = <<-EOF
              #!/bin/bash
              sudo su
              yum install java wget  -y
              wget https://dlcdn.apache.org/tomcat/tomcat-9/v9.0.65/bin/apache-tomcat-9.0.65.tar.gz
              tar -xvzf tomcat-9.0.65
              EOF

  tags = {
    Name = "tomcat_server"
  }
}
provider "aws" {
    region  = "ap-south-1"
}

resource "aws_instance" "server1" {
  ami           = "ami-05c8ca4485f8b138a"
  instance_type = "t2.micro"
  key_name      = "krishna"

  user_data = <<-EOF
              #!/bin/bash
              sudo su
              yum install httpd -y
              systemctl start httpd.service
              systemctl enable httpd.service
              echo "httpd installed" > /var/www/html/index.html
              EOF

  tags = {
    Name = "app server"
  }
}



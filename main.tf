resource "aws_instance" "strapi" {
  ami                         = "ami-04b70fa74e45c3917"
  instance_type               = "t2.medium"
  subnet_id              = "subnet-0c724a9e1beb09e35"
  vpc_security_group_ids = [aws_security_group.strapi_sg.id]
  key_name = "thepair"
  associate_public_ip_address = true
  user_data                   = <<-EOF
                                #!/bin/bash
                                sudo apt update
                                sudo mkdir -p /srv/strapi
                                sudo chown ubuntu:ubuntu /srv/strapi
                                cd /srv/strapi
                                curl -sL https://deb.nodesource.com/setup_18.x | sudo -E bash -
                                sudo apt install -y nodejs
                                sudo npm install -g yarn && sudo npm install -g pm2
                                sudo git clone https://github.com/SAKETH20002/forstrapi.git
                                cd forstrapi/
                                cd row/
                                sudo yarn install
                                sudo pm2 start yarn --name "s" -- start
                                sleep 360
                                EOF

  tags = {
    Name = "Strapi_deploy"
  }
}

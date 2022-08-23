packer {
  required_plugins {
    amazon = {
      version = ">= 0.0.2"
      source  = "github.com/hashicorp/amazon"
    }
  }
}

source "amazon-ebs" "ubuntu" {
  ami_name      = "teamcity-ubuntu-base"
  instance_type = "t2.micro"
  region        = "us-east-1"
  subnet_id     = "subnet-20daee54"
  source_ami_filter {
    filters = {
      name                = "ubuntu/images/*ubuntu-focal-20.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    most_recent = true
    owners      = ["099720109477"]
  }
  ssh_username = "ubuntu"
}

build {
  name = "test-packer"
  sources = [
    "source.amazon-ebs.ubuntu"
  ]

  provisioner "file" {
    source = "TeamCity-2022.04.3.tar.gz" 
    destination = "/tmp/TeamCity-2022.04.3.tar.gz" 
  }

  provisioner "shell" {
    inline = [
      "sudo apt update",
      "sudo apt install -y default-jdk",
      "sudo useradd -m -d /app/TeamCity -s /bin/bash teamcity",
      "sudo tar xvfz /tmp/TeamCity-2022.04.3.tar.gz -C /app/",
      "sudo chown -R teamcity:teamcity /app/TeamCity/"
    ]
  }
}

variable "ssh_username" {}
packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.0.0"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.0.0"
    }
  }
}


source "amazon-ebs" "ubuntu" {
  region        = "us-west-2"
  instance_type = "t2.micro"
  ami_name      = "my-ubuntu-ami-{{timestamp}}"
  ssh_username  = var.ssh_username

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]  
    most_recent = true
  }

  communicator = "ssh"
}

build {
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file    = "./ansible/playbook.yml"
    extra_arguments  = ["--extra-vars", "ansible_host_key_checking=False"]
    ansible_env_vars = ["ANSIBLE_HOST_KEY_CHECKING=False"]
  }
}

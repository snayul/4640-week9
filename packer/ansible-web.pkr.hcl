packer {
  required_plugins {
    amazon = {
      source  = "github.com/hashicorp/amazon"
      version = ">= 1.3.4"
    }
    ansible = {
      source  = "github.com/hashicorp/ansible"
      version = ">= 1.1.2"
    }
  }
}


source "amazon-ebs" "ubuntu" {
  region        = "us-west-2"
  instance_type = "t2.micro"
  ami_name      = "my-ubuntu-ami-{{timestamp}}"
  

  source_ami_filter {
    filters = {
      name                = "ubuntu/images/hvm-ssd/ubuntu-jammy-24.04-amd64-server-*"
      root-device-type    = "ebs"
      virtualization-type = "hvm"
    }
    owners      = ["099720109477"]  
    most_recent = true
  }

  ssh_username  = var.ssh_username
}

build {
  name = "packer-ansible"
  sources = ["source.amazon-ebs.ubuntu"]

  provisioner "ansible" {
    playbook_file    = "../ansible/playbook.yml"
    user = var.ssh_username
    extra_arguments  = ["--extra-vars", "ANSIBLE_HOST_KEY_CHECKING=False"]

  }
}

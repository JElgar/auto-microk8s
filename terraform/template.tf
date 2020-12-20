terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
      version = "1.23.0"
    }
  }
}

# Set the variable value in *.tfvars file
# or using the -var="hcloud_token=..." CLI option
variable "hcloud_token" {}

# Configure the Hetzner Cloud Provider
provider "hcloud" {
  token = var.hcloud_token
}

# Create network
resource "hcloud_network" "microk8s-network" {
  name = "microk8s-network"
  ip_range = "10.0.1.0/24"
}

# Create floating ip
resource "hcloud_floating_ip" "floating-ip" {
  type = "ipv4"
  home_location = "nbg1"
}

# Create a server
resource "hcloud_server" "web" {
  name = "node1"
  image = "ubuntu-20.04"
  server_type = "cx11"
  location = "nbg1"
  ssh_keys = ["jelgar@UbuntuPC"]
    
  connection {
    type        = "ssh"
    user        = "root"
    host        = "${self.ipv4_address}"
    private_key = "${file(var.ssh_key_private)}"
  }


  provisioner "remote-exec" {
    inline = ["sudo apt update -yqq; sudo apt upgrade -yqq; sudo apt-get install python -yqq"]
  }

  provisioner "local-exec" {
    command = "ansible-playbook --inventory '${hcloud_server.web.ipv4_address}, ' ansible/install-microk8s-playbook.yml"
  }
}


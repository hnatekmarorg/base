packer {
  required_plugins {
    tart = {
      version = ">= 1.11.1"
      source  = "github.com/cirruslabs/tart"
    }
  }
}

variable "macos_version" {
  type =  string
  default = "ventura"
}

source "tart-cli" "tart" {
  vm_base_name = "ghcr.io/cirruslabs/macos-${var.macos_version}-base:latest"
  vm_name      = "${var.macos_version}-base"
  cpu_count    = 4
  memory_gb    = 4
  disk_size_gb = 50
  ssh_username = "admin"
  ssh_password = "admin"
  ssh_timeout  = "120s"
}

build {
  sources = ["source.tart-cli.tart"]

  provisioner "shell" {
    inline = ["mkdir .ssh && echo ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIF+vlPAhg+TbppzQhqJ7joeQYU81EphWvyYswBH0oj21 martin@Martins-Mac-mini.local > .ssh/authorized_keys"]
  }

  # more provisioners
}

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
  vm_base_name = "${var.macos_version}-vanilla"
  vm_name      = "gitea.hnatekmar.xyz/osx:${var.macos_version}-base"
  cpu_count    = 4
  memory_gb    = 4
  disk_size_gb = 16
  ssh_username = "admin"
  ssh_password = "admin"
  ssh_timeout  = "120s"
}

build {
  sources = ["source.tart-cli.tart"]

  provisioner "shell" {
    inline = ["echo 'Disabling spotlight indexing...'", "sudo mdutil -a -i off"]
  }

  # more provisioners
}

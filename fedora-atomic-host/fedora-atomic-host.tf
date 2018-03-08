provider "digitalocean" {
    token = "${chomp(file("~/.config/do/token"))}"
}

resource "digitalocean_droplet" "fedora-atomic" {
    name = "TEST-fedora-atomic"
    region = "ams3"
    image = "fedora-27-x64-atomic"
    size = "s-1vcpu-1gb"
    private_networking = "true"
    #user_data = "${file("cloud-init.conf")}"
    ssh_keys = [
      17525420,
      3296803,
      18403719
    ]  
    tags = [
        "${digitalocean_tag.TEST.name}"
    ]
    connection {
        private_key = "${file("/Users/alex/.ssh/id_rsa")}"
    }
    provisioner "remote-exec" {
        script = "scripts/update_atomic.sh"
    }
    provisioner "remote-exec" {
        script = "scripts/wait_for_boot.sh"
    }
}
output "ip" {
  value = "${digitalocean_droplet.fedora-atomic.ipv4_address}"
}

resource "digitalocean_tag" "TEST" {
  name = "TEST"
}
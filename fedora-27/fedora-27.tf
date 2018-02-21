provider "digitalocean" {
    token = "${chomp(file("~/.config/do/token"))}"
}

resource "digitalocean_droplet" "fedora-27" {
    name = "TEST-fedora-27"
    region = "ams3"
    image = "fedora-27-x64"
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
    provisioner "remote-exec" {
        script = "scripts/update.sh"
    }
    provisioner "remote-exec" {
        script = "scripts/wait_for_boot.sh"
    }
}

output "ip" {
  value = "${digitalocean_droplet.fedora-27.ipv4_address}"
}

resource "digitalocean_tag" "TEST" {
  name = "TEST"
}
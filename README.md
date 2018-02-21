# terraform-digitalocean

Useful to quickly spin up some test droplets on DO.

### Configure provider

Generate a Personal Access Token with read/write scope from the [API tab] in the DigitalOcean web interface. Write this token to a file so that it can be referenced in configs. Note: performing this action will leave your token unencrypted on your local disk, please exercise care with this token.

    mkdir -p ~/.config/do
    echo "TOKEN" > ~/.config/do/token

Next, configure the Terraform DigialOcean provider to use the token by creating a `providers.tf` file.

    provider "digitalocean" {
        token = "${chomp(file("~/.config/do/token"))}"
        alias = "default"
    }

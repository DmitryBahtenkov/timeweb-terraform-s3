terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.4.4"

  backend "s3" {
    endpoint = "s3.timeweb.com"
    region = "ru-1"
    bucket = "1d90e41d-terraform-state"
    key  = "terraform.tfstate"
    }
}

provider "twc" {
  token = "<your token>"
}

data "twc_configurator" "example-configurator" {
  location = "ru-1"
}

data "twc_os" "example-os" {
  name = "ubuntu"
  version = "22.04"
}

resource "twc_server" "example-server" {
  name = "Example server"
  os_id = data.twc_os.example-os.id

  configuration {
    configurator_id = data.twc_configurator.example-configurator.id
    disk = 1024 * 10
    cpu = 1
    ram = 1024
  }
}
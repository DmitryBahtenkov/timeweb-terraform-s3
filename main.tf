terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.5.3"

  backend "s3" {
    endpoint = "s3.timeweb.com"
    region = "ru-1"
    bucket = "1d90e41d-terraform-state"
    key  = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    }
}

provider "twc" {
  token = ""
}

data "twc_os" "example-os" {
  name = "ubuntu"
  version = "22.04"
}

data "twc_presets" "example-preset" {
  price_filter {
    from = 300
    to = 400
  }
}

resource "twc_vpc" "example-vpc" {
  name = "Example VPC"
  description = "Some example VPC"
  subnet_v4 = "192.168.0.0/24"
  location = "ru-1"
}

resource "twc_server" "example-server-with-local-network" {
  name = "Example server with local network"
  os_id = data.twc_os.example-os.id

  preset_id = data.twc_presets.example-preset.id

  local_network {
    id = twc_vpc.example-vpc.id
  }
}

output "tw-vpc" {
    value = twc_vpc.example-vpc.id
}
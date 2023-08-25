terraform {
  required_providers {
    twc = {
      source = "tf.timeweb.cloud/timeweb-cloud/timeweb-cloud"
    }
  }
  required_version = ">= 1.5.3"


}

provider "twc" {
  token = ""
}

data "terraform_remote_state" "vpc" {
  backend = "s3"
    config = {
    endpoint = "s3.timeweb.com"
    region = "ru-1"
    bucket = "1d90e41d-terraform-state"
    key  = "terraform.tfstate"
    skip_region_validation = true
    skip_credentials_validation = true
    }

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

resource "twc_server" "example-server-with-local-network" {
  name = "Example server with local network"
  os_id = data.twc_os.example-os.id

  preset_id = data.twc_presets.example-preset.id

  local_network {
    id = data.terraform_remote_state.vpc.outputs.tw-vpc
  }
}
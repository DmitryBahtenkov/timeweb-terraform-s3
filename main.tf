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
    access_key = ""
    secret_key = ""
    skip_region_validation = true
    skip_credentials_validation = true
    }
}

provider "twc" {
  token = ""
}

data "twc_configurator" "configurator" {
  location = "ru-1"
}

data "twc_os" "os" {
  name = "ubuntu"
  version = "20.04"
}

resource "twc_server" "my-timeweb-server" {
  name = "My Timeweb Server"
  os_id = data.twc_os.os.id

  configuration {
    configurator_id = data.twc_configurator.configurator.id
    disk = 102400
    cpu = 2
    ram = 1024 * 4
  }
}
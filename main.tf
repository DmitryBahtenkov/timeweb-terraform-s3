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
  token = "eyJhbGciOiJSUzUxMiIsInR5cCI6IkpXVCIsImtpZCI6IjFrYnhacFJNQGJSI0tSbE1xS1lqIn0.eyJ1c2VyIjoiY2E1MTIxNiIsInR5cGUiOiJhcGlfa2V5IiwicG9ydGFsX3Rva2VuIjoiNjM5MGNhY2MtMmM5Zi00MTY4LThiYjgtZjhhZmE0OTE0MmMzIiwiYXBpX2tleV9pZCI6ImNiZTJjN2ZjLWI1OTYtNDkzYS04ODdkLTBhYWI3ZWRmNGJhNCIsImlhdCI6MTY5Mjg5OTk3OSwiZXhwIjoxNzAwNjc1OTc4fQ.GLvBZXxzSDHo6iNYHC_hfD-eyeFf0QXkllY3fWtGt7jl9seTWlUd6STbs9w8c5W7pMbvvFn2mknumOQ5J9dYXHz1uTA-HXJrmtOelBoHDppIKsDza82kS7a-1UO7F3IiJPBf8JkVhaw39I-nHjbwXKmZZzLTFOiGBF2MDhBJ_NbhfeNXLcyPwbeMvQz8kpUPoP2eKeLB52Tbuz-8-IuyA363BOpLe2NA33PNHALsDsmjoiAZ94P_koKoz99Pi67kA638CooPBN6gejTbxn8Ao8A0awcGbi4NEJBJ0_jzdGddQcRmdy_1uQp8MR522p8Fre_-hI1DPYBAhwNaRb9EJtCofwapFXkQKZGix10PjzcbOVwHcROCbN7Vg7PqRRpYDmv7IfJ-fXl_8TpAorh0ZLobYfcxDI4_usFqpeczifpZC0iUKYCsSx2HlHlhnd6BvfevT0N0fKFuKfLKb85DLbbCpRN4bqYsz2-QQ_56_4EkU8P3E2OwJg9Mp32cGH49"
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
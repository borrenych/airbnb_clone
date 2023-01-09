terraform {
	required_version = ">= 1.1.7"
	
	required_providers {
		yandex = {
			source = "yandex-cloud/yandex"
			version = ">= 0.73"
		}
	}
}

provider "yandex" {
	token     = var.YTOKEN
	cloud_id  = var.yandex_cloud_id
	folder_id = var.yandex_folder_id
	zone 	  = var.yandex_zone
}

data "yandex_compute_image" "ubuntu_image" {
  family = "ubuntu-2204-lts"
}

resource "yandex_compute_instance" "vm_configdemo" {
  name = "configdemo"
  allow_stopping_for_update = true
  platform_id = "standard-v1"

  resources {
	core_fraction = 20
    cores  = var.yandex_cores
    memory = var.yandex_memory
  }

  boot_disk {
    initialize_params {
      image_id = data.yandex_compute_image.ubuntu_image.id
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet_terraform.id
    nat       = true
  }
}

resource "yandex_vpc_network" "network_terraform" {
  name = var.yandex_network
}

resource "yandex_vpc_subnet" "subnet_terraform" {
  name           = var.yandex_subnet
  zone           = var.yandex_zone
  network_id     = yandex_vpc_network.network_terraform.id
  v4_cidr_blocks = ["10.128.0.0/24"]
}

resource "yandex_iam_service_account" "sa" {
  name        = var.yandex_repository_name
  folder_id   = var.yandex_folder_id
}

resource "yandex_container_registry" "my-reg" {
  name = "configdemoregistry"
  folder_id = var.yandex_folder_id
  labels = {
    my-label = "docker"
  }
}
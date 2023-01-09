output "default_instance_public_ip" {
    value = yandex_compute_instance.vm_configdemo.network_interface[0].nat_ip_address
}

output "ubuntu" {
    value = data.yandex_compute_image.ubuntu_image.id
}

output "subnet_id" {
    value = yandex_vpc_subnet.subnet_terraform.network_id
}

output "registry_id" {
    value = yandex_container_registry.my-reg.id
}
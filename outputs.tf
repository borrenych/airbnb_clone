output "default_instance_public_ip" {
    value = yandex_compute_instance.vm_configdemo.network_interface[0].nat_ip_address
}

output "subnet_id" {
    value = yandex_vpc_subnet.network_id
}

output "ubuntu" {
    value = data.yandex_compute_image.ubuntu_image.id
}
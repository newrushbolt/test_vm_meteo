resource "yandex_compute_instance" "vm" {
  count = 1
  name  = "vm-${count.index + 1}"

  resources {
    cores         = 2
    core_fraction = 5
    memory        = 1
  }

  scheduling_policy {
    preemptible = true
  }

  platform_id = "standard-v2"

  boot_disk {
    auto_delete = true

    initialize_params {
      # ubuntu-1804-lts-1593428267-1593437760
      image_id = "fd8vqk0bcfhn31stn2ts"
      size     = 8
      type     = "network-ssd"
    }
  }

  network_interface {
    subnet_id = yandex_vpc_subnet.subnet-1.id
    nat       = true
  }

  metadata = {
    serial-port-enable = "1"
    ssh-keys           = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
  }
}

resource "yandex_vpc_network" "network-1" {
  name = "network1"
}

resource "yandex_vpc_subnet" "subnet-1" {
  name           = "subnet1"
  zone           = "ru-central1-a"
  network_id     = yandex_vpc_network.network-1.id
  v4_cidr_blocks = ["192.168.10.0/24"]
}

# output "internal_ip_address_vm" {
#   value = yandex_compute_instance.vm[*].network_interface.0.ip_address
# }

output "external_ip_address_vm" {
  value = yandex_compute_instance.vm[*].network_interface.0.nat_ip_address
}

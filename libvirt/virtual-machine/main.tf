terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.0"
    }
  }
}

resource "libvirt_cloudinit_disk" "cloudinit_iso" {
  name = "${var.name}-cloudinit-seed.iso"
  user_data = templatefile("${path.module}/templates/cloud-init.cfg", {
    hostname                  = var.name
    domain_name               = var.domain_name
    install_nvidia_gpu_driver = var.gpu_pci_bus == null ? false : true
  })
  pool = var.datastore_name
}


resource "libvirt_volume" "root_disk" {
  name           = "${var.name}-root-disk.qcow2"
  base_volume_id = var.base_volume_id
  size           = var.disk_size_mib * 1024 * 1024 // size must be in bytes
  pool           = var.datastore_name
}

resource "libvirt_domain" "machine" {
  name   = var.name
  memory = var.memory_size_mib
  vcpu   = var.cpu_count
  cpu {
    mode = "host-passthrough"
  }
  machine = "q35"

  firmware = "/usr/share/OVMF/OVMF_CODE_4M.fd"
  nvram {
    file = "/var/lib/libvirt/qemu/nvram/${var.name}-VARS.fd"
  }

  xml {
    xslt = var.gpu_pci_bus == null ? file("${path.module}/files/base-transform.xsl") : templatefile("${path.module}/templates/gpu-transform.xsl", {
      gpu_pci_bus = var.gpu_pci_bus
    })
  }

  console {
    type        = "pty"
    target_port = "0"
    target_type = "serial"
  }

  network_interface {
    network_id     = var.network_id
    hostname       = var.name
    wait_for_lease = true
    addresses      = var.addresses
  }

  cloudinit = libvirt_cloudinit_disk.cloudinit_iso.id
  disk {
    volume_id = libvirt_volume.root_disk.id
  }

  lifecycle {
    ignore_changes = ["cloudinit"]
  }
}
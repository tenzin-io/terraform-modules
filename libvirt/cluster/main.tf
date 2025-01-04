terraform {
  required_version = ">= 1.9.0"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.1"
    }
  }
}

resource "libvirt_pool" "datastore" {
  name = "${var.cluster_name}-${var.cluster_uuid}-datastore"
  type = "dir"
  target {
    path = "${var.datastore_path_prefix}/${var.cluster_name}-${var.cluster_uuid}-datastore"
  }
}

resource "libvirt_pool" "cloud_images" {
  name = "${var.cluster_name}-${var.cluster_uuid}-cloud-images"
  type = "dir"
  target {
    path = "${var.datastore_path_prefix}/${var.cluster_name}-${var.cluster_uuid}-cloud-images"
  }
}

resource "libvirt_volume" "ubuntu_cloud_image" {
  source = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  name   = "noble-server-cloudimg-amd64.img"
  pool   = libvirt_pool.cloud_images.name
  format = "qcow2"
}

# resource "null_resource" "shared_filesystem_setup" {
#   triggers = {
#     hypervisor_host = var.hypervisor_connection.host
#     hypervisor_user = var.hypervisor_connection.user
#     hypervisor_private_key = var.hypervisor_connection.private_key
#     cluster_shared_filesystem_path = local.cluster_shared_filesystem_path
#   }
#   
#   connection {
#     host = self.triggers.hypervisor_host
#     user = self.triggers.hypervisor_user
#     private_key = self.triggers.hypervisor_private_key
#     type = "ssh"
#   }
# 
#   provisioner "remote-exec" {
#     when = create
#     inline = [
#       "sudo mkdir -p ${self.triggers.cluster_shared_filesystem_path}",
#       "sudo chown -R libvirt-qemu:kvm ${self.triggers.cluster_shared_filesystem_path}",
#     ]
#   }
# 
#   provisioner "remote-exec" {
#     when = destroy
#     inline = [
#       "sudo rm -rf ${self.triggers.cluster_shared_filesystem_path}",
#     ]
#   }
# }

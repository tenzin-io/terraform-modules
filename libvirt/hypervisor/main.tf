terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.0"
    }
  }
}

resource "libvirt_network" "network" {
  name      = var.vm_network_name
  mode      = "route"
  bridge    = "virbr1"
  autostart = true
  domain    = var.vm_domain_name
  addresses = [var.vm_network_cidr]

  dhcp {
    enabled = true
  }

  dns {
    enabled    = true
    local_only = false

    // reserved hosts
    hosts {
      hostname = "gateway"
      ip       = cidrhost(var.vm_network_cidr, 1)
    }

    hosts {
      hostname = "cluster"
      ip       = cidrhost(var.vm_network_cidr, 250)
    }

    hosts {
      hostname = "metallb"
      ip       = cidrhost(var.vm_network_cidr, 254)
    }
  }

  dnsmasq_options {
    options {
      option_name = "localise-queries"
    }

    options {
      option_name  = "local"
      option_value = "/${var.vm_domain_name}/"
    }

    options {
      option_name  = "listen-address"
      option_value = "${cidrhost(var.vm_network_cidr, 1)},${var.hypervisor_ip}"
    }

    options {
      option_name  = "dhcp-option"
      option_value = "option:domain-search,${var.vm_domain_name}"
    }

    options {
      option_name  = "cname"
      option_value = "prometheus,metallb"
    }
  }
}

resource "libvirt_pool" "datastore" {
  name = "datastore"
  type = "dir"
  path = "/var/lib/libvirt/machines"
}

// base disk ubuntu image
resource "libvirt_volume" "base_volume" {
  source = "https://cloud-images.ubuntu.com/noble/current/noble-server-cloudimg-amd64.img"
  name   = "ubuntu-noble-server-cloudimg-amd64.qcow2"
  pool   = libvirt_pool.datastore.name
  format = "qcow2"
}
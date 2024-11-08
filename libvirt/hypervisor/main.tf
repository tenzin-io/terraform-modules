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
  autostart = true
  domain    = var.vm_domain_name
  addresses = [var.vm_network_cidr]

  dhcp {
    enabled = true
  }

  xml {
    xslt = templatefile("${path.module}/templates/network.xslt", {
      dhcp_range_start = cidrhost(var.vm_network_cidr, var.dhcp_range_start)
      dhcp_range_end   = cidrhost(var.vm_network_cidr, var.dhcp_range_end)
    })
  }

  dns {
    enabled    = true
    local_only = false

    dynamic "hosts" {
      for_each = toset(var.dns_host_records)
      content {
        hostname = hosts.value.hostname
        ip       = cidrhost(var.vm_network_cidr, hosts.value.host_number)
      }
    }
    // reserved hosts
    hosts {
      hostname = "gateway"
      ip       = cidrhost(var.vm_network_cidr, 1)
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

  }
}

resource "libvirt_pool" "datastore" {
  name = var.datastore_name
  type = "dir"
  path = var.datastore_path
}
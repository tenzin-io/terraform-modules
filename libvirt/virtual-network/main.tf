terraform {
  required_version = "~> 1.9.8"
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.8.1"
    }
  }
}

resource "libvirt_network" "vpc_network" {
  name      = var.name
  mode      = var.routing_mode
  autostart = true
  domain    = var.domain_name
  addresses = [var.network_cidr]

  dhcp {
    enabled = true
  }

  xml {
    xslt = templatefile("${path.module}/templates/network.xslt", {
      dhcp_range_start = cidrhost(var.network_cidr, var.dhcp_range_start)
      dhcp_range_end   = cidrhost(var.network_cidr, var.dhcp_range_end)
    })
  }

  dns {
    enabled    = true
    local_only = false

    // reserved hosts
    hosts {
      hostname = "gateway"
      ip       = cidrhost(var.network_cidr, 1)
    }

    dynamic "hosts" {
      for_each = toset(var.dns_hosts)
      content {
        hostname = each.value.hostname
        ip       = each.value.ip
      }
    }
  }

  dnsmasq_options {
    options {
      option_name = "localise-queries"
    }

    options {
      option_name  = "local"
      option_value = "/${var.domain_name}/"
    }

    options {
      option_name  = "listen-address"
      option_value = cidrhost(var.network_cidr, 1)
    }

    options {
      option_name  = "dhcp-option"
      option_value = "option:domain-search,${var.domain_name}"
    }
  }

}
resource "libvirt_network" "vpc_network" {
  name      = "${var.cluster_name}-network"
  mode      = "nat"
  autostart = true
  domain    = var.vpc_domain_name
  addresses = [var.vpc_network_cidr]

  dhcp {
    enabled = true
  }

  xml {
    xslt = templatefile("${path.module}/templates/network.xslt", {
      dhcp_range_start = cidrhost(var.vpc_network_cidr, 10)
      dhcp_range_end   = cidrhost(var.vpc_network_cidr, 149)
    })
  }

  dns {
    enabled    = true
    local_only = false

    // reserved hosts
    hosts {
      hostname = "gateway"
      ip       = cidrhost(var.vpc_network_cidr, 1)
    }
  }

  dnsmasq_options {
    options {
      option_name = "localise-queries"
    }

    options {
      option_name  = "local"
      option_value = "/${var.vpc_domain_name}/"
    }

    options {
      option_name  = "listen-address"
      option_value = cidrhost(var.vpc_network_cidr, 1)
    }

    options {
      option_name  = "dhcp-option"
      option_value = "option:domain-search,${var.vpc_domain_name}"
    }

  }
}
# README
A Terraform module to help setup a libvirtd hypervisor host with the base VM infrastructure.
<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | n/a | `string` | n/a | yes |
| <a name="input_hypervisor_ip"></a> [hypervisor\_ip](#input\_hypervisor\_ip) | n/a | `string` | n/a | yes |
| <a name="input_network_cidr"></a> [network\_cidr](#input\_network\_cidr) | n/a | `string` | n/a | yes |
| <a name="input_network_name"></a> [network\_name](#input\_network\_name) | n/a | `string` | `"vm-network"` | no |
<!-- END_TF_DOCS -->
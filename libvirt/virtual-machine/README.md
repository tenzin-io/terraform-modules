# README
A Terraform module that creates virtual machines on a libvirtd host.
<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_addresses"></a> [addresses](#input\_addresses) | A list of 1 IPv4 address and/or IPv6 address | `list(string)` | n/a | yes |
| <a name="input_base_volume_id"></a> [base\_volume\_id](#input\_base\_volume\_id) | n/a | `string` | n/a | yes |
| <a name="input_cpu_count"></a> [cpu\_count](#input\_cpu\_count) | n/a | `number` | `2` | no |
| <a name="input_datastore_name"></a> [datastore\_name](#input\_datastore\_name) | The name of the datastore | `string` | n/a | yes |
| <a name="input_disk_size_mib"></a> [disk\_size\_mib](#input\_disk\_size\_mib) | n/a | `number` | `1024` | no |
| <a name="input_domain_name"></a> [domain\_name](#input\_domain\_name) | The name of the domain | `string` | `"virtual.lan"` | no |
| <a name="input_gpu_pci_bus"></a> [gpu\_pci\_bus](#input\_gpu\_pci\_bus) | The PCI bus number of the GPU device | `string` | `null` | no |
| <a name="input_memory_size_mib"></a> [memory\_size\_mib](#input\_memory\_size\_mib) | n/a | `number` | `2048` | no |
| <a name="input_name"></a> [name](#input\_name) | The name of the virtual machine | `string` | n/a | yes |
| <a name="input_network_id"></a> [network\_id](#input\_network\_id) | n/a | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
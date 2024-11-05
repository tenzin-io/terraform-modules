# README
A Terraform module to help setup a libvirtd hypervisor host with the base VM infrastructure.
<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_datastore_name"></a> [datastore\_name](#input\_datastore\_name) | The name of the datastore | `string` | `"datastore"` | no |
| <a name="input_datastore_path"></a> [datastore\_path](#input\_datastore\_path) | The datastore folder path | `string` | `"/var/lib/libvirt/machines"` | no |
| <a name="input_dhcp_range_end"></a> [dhcp\_range\_end](#input\_dhcp\_range\_end) | The end host number of the DHCP range | `number` | `150` | no |
| <a name="input_dhcp_range_start"></a> [dhcp\_range\_start](#input\_dhcp\_range\_start) | The start host number of the DHCP range | `number` | `10` | no |
| <a name="input_dns_host_records"></a> [dns\_host\_records](#input\_dns\_host\_records) | A list of host records to create in the virtual domain | <pre>list(object({<br>    hostname    = string<br>    host_number = string<br>  }))</pre> | `[]` | no |
| <a name="input_hypervisor_ip"></a> [hypervisor\_ip](#input\_hypervisor\_ip) | The hypervisor IP address | `string` | n/a | yes |
| <a name="input_vm_domain_name"></a> [vm\_domain\_name](#input\_vm\_domain\_name) | The domain name of the VM network | `string` | n/a | yes |
| <a name="input_vm_network_cidr"></a> [vm\_network\_cidr](#input\_vm\_network\_cidr) | The VM network CIDR block | `string` | n/a | yes |
| <a name="input_vm_network_name"></a> [vm\_network\_name](#input\_vm\_network\_name) | The hypervisor local VM network name | `string` | `"vm-network"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_datastore_id"></a> [datastore\_id](#output\_datastore\_id) | The datastore id |
| <a name="output_datastore_name"></a> [datastore\_name](#output\_datastore\_name) | The datastore name |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The VM network id |
| <a name="output_vm_network_cidr"></a> [vm\_network\_cidr](#output\_vm\_network\_cidr) | The VM network CIDR |
<!-- END_TF_DOCS -->
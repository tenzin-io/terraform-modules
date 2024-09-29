# README
A Terraform module to help setup a libvirtd hypervisor host with the base VM infrastructure.
<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_hypervisor_ip"></a> [hypervisor\_ip](#input\_hypervisor\_ip) | The hypervisor IP address | `string` | n/a | yes |
| <a name="input_vm_domain_name"></a> [vm\_domain\_name](#input\_vm\_domain\_name) | The domain name of the VM network | `string` | n/a | yes |
| <a name="input_vm_network_cidr"></a> [vm\_network\_cidr](#input\_vm\_network\_cidr) | The VM network CIDR block | `string` | n/a | yes |
| <a name="input_vm_network_name"></a> [vm\_network\_name](#input\_vm\_network\_name) | The hypervisor local VM network name | `string` | `"vm-network"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_base_volume_id"></a> [base\_volume\_id](#output\_base\_volume\_id) | The base OS volume id |
| <a name="output_datastore_id"></a> [datastore\_id](#output\_datastore\_id) | The datastore id |
| <a name="output_datastore_name"></a> [datastore\_name](#output\_datastore\_name) | The datastore name |
| <a name="output_network_id"></a> [network\_id](#output\_network\_id) | The VM network id |
<!-- END_TF_DOCS -->
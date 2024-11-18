# README
A Terraform module that creates virtual machines on a libvirtd host.
<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_alternative_domain_names"></a> [alternative\_domain\_names](#input\_alternative\_domain\_names) | A list of alternative domain names for the VM network | `list(string)` | `[]` | no |
| <a name="input_base_volume_id"></a> [base\_volume\_id](#input\_base\_volume\_id) | n/a | `string` | n/a | yes |
| <a name="input_cloudflare_tunnel_token"></a> [cloudflare\_tunnel\_token](#input\_cloudflare\_tunnel\_token) | n/a | `string` | `""` | no |
| <a name="input_cluster_name"></a> [cluster\_name](#input\_cluster\_name) | The name of the cluster | `string` | n/a | yes |
| <a name="input_datastore_name"></a> [datastore\_name](#input\_datastore\_name) | n/a | `string` | n/a | yes |
| <a name="input_docker_hub_token"></a> [docker\_hub\_token](#input\_docker\_hub\_token) | n/a | `string` | n/a | yes |
| <a name="input_docker_hub_user"></a> [docker\_hub\_user](#input\_docker\_hub\_user) | n/a | `string` | n/a | yes |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | n/a | `string` | `""` | no |
| <a name="input_vm_cpu_count"></a> [vm\_cpu\_count](#input\_vm\_cpu\_count) | n/a | `number` | `2` | no |
| <a name="input_vm_data_disks"></a> [vm\_data\_disks](#input\_vm\_data\_disks) | A map of data disks to add to the virtual machine | <pre>map(object({<br/>    mount_path    = string<br/>    disk_size_mib = number<br/>    fs_type       = optional(string, "ext4")<br/>  }))</pre> | `{}` | no |
| <a name="input_vm_disk_size_mib"></a> [vm\_disk\_size\_mib](#input\_vm\_disk\_size\_mib) | n/a | `number` | `1024` | no |
| <a name="input_vm_memory_size_mib"></a> [vm\_memory\_size\_mib](#input\_vm\_memory\_size\_mib) | n/a | `number` | `2048` | no |
| <a name="input_vm_node_count"></a> [vm\_node\_count](#input\_vm\_node\_count) | The number of virtual machine nodes in the cluster | `number` | `2` | no |
| <a name="input_vpc_domain_name"></a> [vpc\_domain\_name](#input\_vpc\_domain\_name) | The domain name of the VM network | `string` | `"virtual.lan"` | no |
| <a name="input_vpc_network_cidr"></a> [vpc\_network\_cidr](#input\_vpc\_network\_cidr) | The VM network CIDR block | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
# README
A Terraform module repository to deploy local-path-provisioner add-on to a Kubernetes cluster.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_default_storage_class"></a> [default\_storage\_class](#input\_default\_storage\_class) | Set the local-path-provisioner to be the default storage class for persistent volume claims | `bool` | `true` | no |
| <a name="input_local_path"></a> [local\_path](#input\_local\_path) | The path on the node in which to place persistent volumes | `string` | `"/opt/local-path-provisioner"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->
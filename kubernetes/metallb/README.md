# README
A Terraform module to install MetalLB on my home lab Kubernetes cluster.

<!-- BEGIN_TF_DOCS -->


## Resources

| Name | Type |
|------|------|
| [helm_release.metallb](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.metallb_config](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_ip_pool_range"></a> [ip\_pool\_range](#input\_ip\_pool\_range) | The IP address pool range given to MetalLB. | `string` | n/a | yes |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace for MetalLB deployment. | `string` | `"metallb"` | no |
<!-- END_TF_DOCS -->

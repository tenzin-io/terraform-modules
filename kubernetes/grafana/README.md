# README
A Terraform module repository to install Grafana on my Kubernetes clusters.

<!-- BEGIN_TF_DOCS -->


## Resources

| Name | Type |
|------|------|
| [helm_release.grafana](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cert_issuer_name"></a> [cert\_issuer\_name](#input\_cert\_issuer\_name) | The cert-manager certificate issuer name. | `string` | n/a | yes |
| <a name="input_enable_github_oauth"></a> [enable\_github\_oauth](#input\_enable\_github\_oauth) | Enable GitHub OAuth for Grafana | `bool` | `false` | no |
| <a name="input_github_oauth_client_id"></a> [github\_oauth\_client\_id](#input\_github\_oauth\_client\_id) | GitHub OAuth app client id | `string` | `""` | no |
| <a name="input_github_oauth_client_secret"></a> [github\_oauth\_client\_secret](#input\_github\_oauth\_client\_secret) | GitHub OAuth app client secret | `string` | `""` | no |
| <a name="input_github_org_name"></a> [github\_org\_name](#input\_github\_org\_name) | The name of the GitHub organization to allow sign-in to Granfa | `string` | `""` | no |
| <a name="input_grafana_ingress_host"></a> [grafana\_ingress\_host](#input\_grafana\_ingress\_host) | The Grafana hostname placed on ingress | `string` | n/a | yes |
| <a name="input_grafana_volume_size"></a> [grafana\_volume\_size](#input\_grafana\_volume\_size) | The persistent volume size to store Grafana data | `string` | `"20Gi"` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy Grafana | `string` | `"monitoring"` | no |
<!-- END_TF_DOCS -->

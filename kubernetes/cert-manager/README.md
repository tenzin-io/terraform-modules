# README
A Terraform module that will install cert-manager for my home lab Kubernetes cluster.

<!-- BEGIN_TF_DOCS -->


## Resources

| Name | Type |
|------|------|
| [helm_release.cert_manager](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_manifest.lets_encrypt_cluster_issuer](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_secret_v1.cloudflare_api_token](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_api_token"></a> [cloudflare\_api\_token](#input\_cloudflare\_api\_token) | CloudFlare API token | `string` | n/a | yes |
| <a name="input_enable_lets_encrypt_issuer"></a> [enable\_lets\_encrypt\_issuer](#input\_enable\_lets\_encrypt\_issuer) | Enable the Lets Encrypt issuer | `bool` | `true` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy cert-manager | `string` | `"cert-manager"` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_cert_issuer_name"></a> [cert\_issuer\_name](#output\_cert\_issuer\_name) | The name of the certificate issuer |
<!-- END_TF_DOCS -->

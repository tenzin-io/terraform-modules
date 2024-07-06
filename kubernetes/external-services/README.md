# terraform-tenzin-nginx-ingress-external
A Terraform module to deploy Nginx Ingresses to resources external of the Kubernetes cluster.

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.external_service](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_certificate_issuer"></a> [certificate\_issuer](#input\_certificate\_issuer) | The name of the certificate issuer for the cluster | `string` | `"lets-encrypt"` | no |
| <a name="input_external_domain_name"></a> [external\_domain\_name](#input\_external\_domain\_name) | The external domain name to append to the service name | `string` | n/a | yes |
| <a name="input_external_services"></a> [external\_services](#input\_external\_services) | A map of external services | <pre>map(object({<br>    address = string<br>    port    = string<br>  }))</pre> | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy the ingresses for external services. | `string` | `"external-services"` | no |
| <a name="input_request_body_size"></a> [request\_body\_size](#input\_request\_body\_size) | The maximum size of the request body | `string` | `"100m"` | no |
<!-- END_TF_DOCS -->

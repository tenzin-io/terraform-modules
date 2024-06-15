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
| <a name="input_external_services"></a> [external\_services](#input\_external\_services) | A map of external services. | <pre>map(object({<br>    address = string<br>    port    = string<br>  }))</pre> | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy the ingresses for external services. | `string` | `"external-services"` | no |
<!-- END_TF_DOCS -->

# README
A Terraform module repository to install Nginx ingress controller on my home lab Kubernetes cluster.

Useful Nginx ingress tuning and setup:
- <https://kubernetes.github.io/ingress-nginx/user-guide/tls/>
- <https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md>

<!-- BEGIN_TF_DOCS -->


## Resources

| Name | Type |
|------|------|
| [helm_release.ingress_nginx](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [kubernetes_namespace_v1.nginx_namespace](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/namespace_v1) | resource |
| [kubernetes_role_binding_v1.tailscale_role_binding](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_binding_v1) | resource |
| [kubernetes_role_v1.tailscale_role](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/role_v1) | resource |
| [kubernetes_secret_v1.tailscale_auth_key_secret](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret_v1) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_enable_tailscale_tunnel"></a> [enable\_tailscale\_tunnel](#input\_enable\_tailscale\_tunnel) | Enable Tailscale tunnel on Nginx controller. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy Nginx. | `string` | `"ingress-nginx"` | no |
| <a name="input_nginx_service_account_name"></a> [nginx\_service\_account\_name](#input\_nginx\_service\_account\_name) | The service account name for Nginx ingress controller. | `string` | `"ingress-nginx"` | no |
| <a name="input_nginx_service_type"></a> [nginx\_service\_type](#input\_nginx\_service\_type) | The type of Nginx ingress service. Ex. NodePort or LoadBalancer. | `string` | `"LoadBalancer"` | no |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | The Tailscale auth key to join to a Tailscale network. | `string` | `null` | no |
| <a name="input_tailscale_hostname"></a> [tailscale\_hostname](#input\_tailscale\_hostname) | The Tailscale hostname to join to a Tailscale network. | `string` | `null` | no |
<!-- END_TF_DOCS -->

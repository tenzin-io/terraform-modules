# README
A Terraform module repository to install Nginx ingress controller on my home lab Kubernetes cluster.

Useful Nginx ingress tuning and setup:
- <https://kubernetes.github.io/ingress-nginx/user-guide/tls/>
- <https://github.com/kubernetes/ingress-nginx/blob/main/docs/user-guide/nginx-configuration/annotations.md>

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cloudflare_tunnel_token"></a> [cloudflare\_tunnel\_token](#input\_cloudflare\_tunnel\_token) | The Cloudflare tunnel token to join to a Cloudflare network. | `string` | `null` | no |
| <a name="input_enable_cloudflare_tunnel"></a> [enable\_cloudflare\_tunnel](#input\_enable\_cloudflare\_tunnel) | Enable Cloudflare tunnel on Nginx controller. | `bool` | `false` | no |
| <a name="input_enable_tailscale_tunnel"></a> [enable\_tailscale\_tunnel](#input\_enable\_tailscale\_tunnel) | Enable Tailscale tunnel on Nginx controller. | `bool` | `false` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy Nginx. | `string` | `"ingress-nginx"` | no |
| <a name="input_nginx_service_account_name"></a> [nginx\_service\_account\_name](#input\_nginx\_service\_account\_name) | The service account name for Nginx ingress controller. | `string` | `"ingress-nginx"` | no |
| <a name="input_nginx_service_type"></a> [nginx\_service\_type](#input\_nginx\_service\_type) | The type of Nginx ingress service. Ex. NodePort or LoadBalancer. | `string` | `"LoadBalancer"` | no |
| <a name="input_tailscale_auth_key"></a> [tailscale\_auth\_key](#input\_tailscale\_auth\_key) | The Tailscale auth key to join to a Tailscale network. | `string` | `null` | no |
| <a name="input_tailscale_hostname"></a> [tailscale\_hostname](#input\_tailscale\_hostname) | The Tailscale hostname to join to a Tailscale network. | `string` | `null` | no |
<!-- END_TF_DOCS -->

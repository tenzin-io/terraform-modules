# README
A Terraform module to deploy GitHub Actions Runner Controller to my Kubernetes clusters.
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | ~> 1.0 |
| <a name="requirement_helm"></a> [helm](#requirement\_helm) | ~> 2.0 |

## Resources

| Name | Type |
|------|------|
| [helm_release.actions_runner_controller](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |
| [helm_release.actions_runner_set](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_github_app_id"></a> [github\_app\_id](#input\_github\_app\_id) | The GitHub App ID | `number` | n/a | yes |
| <a name="input_github_app_installation_id"></a> [github\_app\_installation\_id](#input\_github\_app\_installation\_id) | The GitHub App Installation ID | `number` | n/a | yes |
| <a name="input_github_app_private_key"></a> [github\_app\_private\_key](#input\_github\_app\_private\_key) | The GitHub App Private Key | `string` | n/a | yes |
| <a name="input_github_organization_url"></a> [github\_organization\_url](#input\_github\_organization\_url) | The GitHub Organization URL | `string` | n/a | yes |
| <a name="input_maximum_runners"></a> [maximum\_runners](#input\_maximum\_runners) | The maximum number of runners to scale to | `number` | `5` | no |
| <a name="input_minimum_runners"></a> [minimum\_runners](#input\_minimum\_runners) | The minimum number of runners to scale to | `number` | `1` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to deploy the actions-runner-controller | `string` | `"actions-runner"` | no |
| <a name="input_runner_image"></a> [runner\_image](#input\_runner\_image) | The image to use for the runner | `string` | `"ghcr.io/actions/actions-runner:latest"` | no |
| <a name="input_runner_set_name"></a> [runner\_set\_name](#input\_runner\_set\_name) | The name of the runner set | `string` | n/a | yes |
<!-- END_TF_DOCS -->
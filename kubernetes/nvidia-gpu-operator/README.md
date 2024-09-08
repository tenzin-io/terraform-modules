# README
A Terraform module that installs nvidia-gpu-operator on my Kubernetes cluster.

<!-- BEGIN_TF_DOCS -->
## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_namespace"></a> [namespace](#input\_namespace) | The namespace to install the nvidia-gpu-operator chart | `string` | `"gpu-operator"` | no |
| <a name="input_nvidia_gpu_slices"></a> [nvidia\_gpu\_slices](#input\_nvidia\_gpu\_slices) | The number of GPU slices | `number` | `8` | no |
<!-- END_TF_DOCS -->
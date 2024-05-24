# README
A Terraform module repository to setup Calico on a Kubernetes cluster.
<!-- BEGIN_TF_DOCS -->

## Resources

| Name | Type |
|------|------|
| [helm_release.calico](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_pod_cidr_network"></a> [pod\_cidr\_network](#input\_pod\_cidr\_network) | The pod CIDR network to use for the Calico installation. | `string` | `"10.10.0.0/16"` | no |
<!-- END_TF_DOCS -->
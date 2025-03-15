# route53

<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1 |
| <a name="requirement_sops"></a> [sops](#requirement\_sops) | >= 1 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_sops"></a> [sops](#provider\_sops) | 1.1.1 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_domains"></a> [domains](#module\_domains) | ./modules/dyndns | n/a |

## Resources

| Name | Type |
|------|------|
| [sops_file.secrets](https://registry.terraform.io/providers/carlpett/sops/latest/docs/data-sources/file) | data source |

## Inputs

No inputs.

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_ddns_settings"></a> [ddns\_settings](#output\_ddns\_settings) | n/a |
| <a name="output_secrets"></a> [secrets](#output\_secrets) | n/a |
<!-- END_TF_DOCS -->

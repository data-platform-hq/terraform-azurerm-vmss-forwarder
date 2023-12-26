# Azure VMSS Forwarder Terraform module
Terraform module for creation Azure VMSS Forwarder

## Usage
This module provides an ability to deploy Azure VMSS Forwarder.

```hcl
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name                                                                      | Version   |
|---------------------------------------------------------------------------|-----------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0  |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm)       | >= 3.71.0 |
| <a name="requirement_random"></a> [random](#requirement\_random)          | >= 3.5.0  |

## Providers

| Name                                                          | Version |
|---------------------------------------------------------------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | 3.71.0  |
| <a name="requirement_random"></a> [random](#requirement\_random) | >= 3.5.0  |

## Modules

No modules.
| Module                                                                      | Path   |  Version
|---------------------------------------------------------------------------|-----------|-----------|
[Load Balancer](https://github.com/data-platform-hq/terraform-azurerm-load-balancer) |  "data-platform-hq/load-balancer/azurerm" | 1.0.0 |
[Azure Virtual Machine Scale Sets](https://github.com/data-platform-hq/terraform-azurerm-vmss) |  "data-platform-hq/vmss/azurerm" | 1.2.0 |

## Resources

| Name                                                                                                                                                                | Type     |
|---------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------|
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password)                                                     | resource |

## Inputs

| Name                                                                                                                                                                 | Description                                                                                                                                                                             | Type           | Default                                                                                                                                                         | Required |
|----------------------------------------------------------------------------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|----------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------|:--------:|
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group)| The name of the resource group. | `string` | n/a |   yes    |
| <a name="input_location"></a> [location](#input\_location)| The Azure Region in which resources would be created. | `string` | n/a |   yes    |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name)| Load Balancer name | `string` | n/a |   yes    |
| <a name="input_vm_scale_set_name"></a> [vm\_scale\_set\_name](#input\_vm\_scale\_set\_name)| VM Scale Set name | `string` | n/a |   yes    |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id)| The ID of the Subnet where this Network first Interface should be located in. | `string` | n/a |   yes    |
| <a name="input_spoke_cidrs"></a> [spoke\_cidrs](#input\_spoke\_cidrs)| List of IP Address CIDRs that would be managed in Iptables configuration. Traffic would be forwarded between those networks. | `list(string)` |  []  |   no    |
| <a name="input_default_dns_server_ip_address"></a> [default\_dns\_server\_ip\_address](#input\_default\_dns\_server\_ip\_address)| IP Address of the DNS Server that would resolve queries by default. Default value is an Azure DNS Server public ip | `string` |  168.63.129.16  |   no    |
| <a name="input_additional_dns_zones"></a> [additional\_dns\_zones](#input\_additional\_dns\_zones)| List of objects to configure custom DNS zones. DNS Traffic would be forwarded to mentioned DNS Server IP Address in case zone name is matched in query | <pre>list(object({<br>  zone_name           = string<br>  server_ip_addresses = list(string)}))<br>}))</pre> |  []  |   no    |
| <a name="input_public_ip_prefix_enabled"></a> [public\_ip\_prefix\_enabled](#input\_public\_ip\_prefix\_enabled)| Boolean flag that determines whether Public IP Address prefix is assigned to VMSS. By default it is disable because NAT Gateway is used for default outbound traffic. | `string` | false |   no    |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username)| VM Scale Set admin username | `string` | azureuser |   no    |


## Outputs

| Name                                                                                                                | Description                                   |
|---------------------------------------------------------------------------------------------------------------------|-----------------------------------------------|
| <a name="output_vmss_id"></a> [vmss\_id](#output\_vmss\_id)                                                                          | VM Scale Sets id                  |
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id)                                       | Load Balancer id |
| <a name="output_lb_private_ip"></a> [lb\_private\_ip](#output\_lb\_private\_ip) | Load Balancer private ip address   |
| <a name="output_vmss_password"></a> [vmss\_password](#output\_vmss\_password) | VM Scale Sets admin password value   |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-vmss-forwarder/blob/main/LICENSE)

# Azure VMSS Forwarder Terraform module
Terraform module for creation Azure VMSS Forwarder

## Usage
This module provides an ability to deploy Azure VMSS Forwarder.

```hcl
data "azurerm_resource_group" "example" {
  name = "example"
}

data "azurerm_subnet" "example" {
  name                 = "example-subnet-name"
  virtual_network_name = "example"
  resource_group_name  = data.azurerm_resource_group.example.name
}

module "vmss_forwarder" {
  source  = "data-platform-hq/vmss-forwarder/azurerm"
  version = "~> 1.0"

  load_balancer_name   = "example-load-balancer-name"
  vm_scale_set_name    = "example-vm-scale-set-name"
  location             = "eastus"
  resource_group       = data.azurerm_resource_group.example.name
  subnet_id            = data.azurerm_subnet.example.id
  spoke_cidrs          = ["10.0.0.0/8"]
  additional_dns_zones =  [
    {
      zone_name           = "example.com"
      server_ip_addresses = ["10.120.0.4"]
    }
  ]
}
```
<!-- BEGIN_TF_DOCS -->
## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.0.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | >= 3.75.0 |
| <a name="requirement_random"></a> [random](#requirement\_random) | >=3.5.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_random"></a> [random](#provider\_random) | >=3.5.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_lb"></a> [lb](#module\_lb) | data-platform-hq/load-balancer/azurerm | 1.0.1 |
| <a name="module_vmss"></a> [vmss](#module\_vmss) | data-platform-hq/vmss/azurerm | 1.2.4 |

## Resources

| Name | Type |
|------|------|
| [random_password.this](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/password) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_additional_dns_zones"></a> [additional\_dns\_zones](#input\_additional\_dns\_zones) | List of objects to configure custom DNS zones. DNS Traffic would be forwarded to mentioned DNS Server IP Address in case zone name is matched in query | <pre>list(object({<br>    zone_name           = string<br>    server_ip_addresses = list(string)<br>  }))</pre> | `[]` | no |
| <a name="input_admin_username"></a> [admin\_username](#input\_admin\_username) | VM Scale Set admin username | `string` | `"azureuser"` | no |
| <a name="input_analytics_workspace_id"></a> [analytics\_workspace\_id](#input\_analytics\_workspace\_id) | Resource ID of Log Analytics Workspace | `string` | `null` | no |
| <a name="input_default_dns_servers"></a> [default\_dns\_servers](#input\_default\_dns\_servers) | List of IP Addresses of the DNS Servers that would resolve queries by default. Default value is an Azure DNS Server public ip | `list(string)` | <pre>[<br>  "168.63.129.16"<br>]</pre> | no |
| <a name="input_dnssec_validation"></a> [dnssec\_validation](#input\_dnssec\_validation) | DNSSEC validation value in bind9 config | `string` | `"no"` | no |
| <a name="input_drc_datasource_name"></a> [drc\_datasource\_name](#input\_drc\_datasource\_name) | Datasource syslog name | `string` | `"datasource-syslog"` | no |
| <a name="input_drc_enabled"></a> [drc\_enabled](#input\_drc\_enabled) | Enable data collection rule. var.analytics\_workspace\_id must be provided | `bool` | `false` | no |
| <a name="input_drc_facility_names"></a> [drc\_facility\_names](#input\_drc\_facility\_names) | List of Facility names | `list(string)` | <pre>[<br>  "daemon",<br>  "syslog",<br>  "user"<br>]</pre> | no |
| <a name="input_drc_log_levels"></a> [drc\_log\_levels](#input\_drc\_log\_levels) | List of Log levels | `list(string)` | <pre>[<br>  "Debug"<br>]</pre> | no |
| <a name="input_lb_enable_diagnostic_setting"></a> [lb\_enable\_diagnostic\_setting](#input\_lb\_enable\_diagnostic\_setting) | Enable diagnostic setting. var.analytics\_workspace\_id must be provided | `bool` | `false` | no |
| <a name="input_load_balancer_name"></a> [load\_balancer\_name](#input\_load\_balancer\_name) | Load Balancer name | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | The Azure Region in which resources would be created. | `string` | n/a | yes |
| <a name="input_public_ip_prefix_enabled"></a> [public\_ip\_prefix\_enabled](#input\_public\_ip\_prefix\_enabled) | Boolean flag that determines whether Public IP Address prefix is assigned to VMSS. By default it is disable because NAT Gateway is used for default outbound traffic. | `string` | `false` | no |
| <a name="input_resource_group"></a> [resource\_group](#input\_resource\_group) | The name of the resource group. | `string` | n/a | yes |
| <a name="input_spoke_cidrs"></a> [spoke\_cidrs](#input\_spoke\_cidrs) | List of IP Address CIDRs that would be managed in Iptables configuration. Traffic would be forwarded between those networks. | `list(string)` | `[]` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | The ID of the Subnet where this Network first Interface should be located in. | `string` | n/a | yes |
| <a name="input_tags"></a> [tags](#input\_tags) | Resource tags | `map(any)` | `{}` | no |
| <a name="input_vm_scale_set_name"></a> [vm\_scale\_set\_name](#input\_vm\_scale\_set\_name) | VM Scale Set name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_lb_id"></a> [lb\_id](#output\_lb\_id) | Load Balancer id |
| <a name="output_lb_private_ip"></a> [lb\_private\_ip](#output\_lb\_private\_ip) | Load Balancer private ip address |
| <a name="output_vmss_id"></a> [vmss\_id](#output\_vmss\_id) | VM Scale Sets id |
| <a name="output_vmss_password"></a> [vmss\_password](#output\_vmss\_password) | VM Scale Sets admin password value |
| <a name="output_vmss_username"></a> [vmss\_username](#output\_vmss\_username) | VM Scale Sets admin username value |
<!-- END_TF_DOCS -->

## License

Apache 2 Licensed. For more information please see [LICENSE](https://github.com/data-platform-hq/terraform-azurerm-vmss-forwarder/blob/main/LICENSE)

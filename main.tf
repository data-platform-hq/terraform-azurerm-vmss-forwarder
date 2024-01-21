module "lb" {
  source  = "data-platform-hq/load-balancer/azurerm"
  version = "1.0.1"

  tags                      = var.tags
  resource_group            = var.resource_group
  location                  = var.location
  load_balancer_name        = var.load_balancer_name
  enable_diagnostic_setting = var.lb_enable_diagnostic_setting
  analytics_workspace_id    = var.analytics_workspace_id
  lb_frontend_ip_configurations = [{
    name      = "primary"
    subnet_id = var.subnet_id
    rules = [{
      name              = "dynamic"
      protocol          = "All"
      frontend_port     = 0
      backend_port      = 0
      load_distribution = "SourceIP"
    }]
  }]
}

resource "random_password" "this" {
  length           = 16
  special          = true
  override_special = "_!@#$%&*()-+="
}

module "vmss" {
  source  = "data-platform-hq/vmss/azurerm"
  version = "1.2.0"

  tags                     = var.tags
  resource_group           = var.resource_group
  location                 = var.location
  scale_set_name           = var.vm_scale_set_name
  subnet_id                = var.subnet_id
  public_ip_prefix_enabled = var.public_ip_prefix_enabled
  scale_set_configuration = {
    disable_password_authentication = false
    admin_username                  = var.admin_username
    admin_password                  = random_password.this.result
    lb_backend_address_pool_ids     = [module.lb.lb_backend_address_pool_id]
    overprovision                   = true
    enable_ip_forwarding_interface  = true
  }

  extensions = [{
    name                 = "IptablesAndDNSConfig"
    publisher            = "Microsoft.Azure.Extensions"
    type                 = "CustomScript"
    type_handler_version = "2.0"
    settings = jsonencode({
      "script" : (base64encode(templatefile("${path.module}/iptables.sh.tftpl", {
        DNS_VNET_CIDRS = join("; ", var.spoke_cidrs),
        DNS_ZONES      = { for object in var.additional_dns_zones : object.zone_name => join("; ", object.server_ip_addresses) if length(object.server_ip_addresses) != 0 }
        DEFAULT_DNS    = join("; ", var.default_dns_servers)
        FW_VNET_CIDRS  = join(" ", var.spoke_cidrs),
      })))
    })
    }, {
    name                 = "AzureNetworkWatcherExtension"
    publisher            = "Microsoft.Azure.NetworkWatcher"
    type                 = "NetworkWatcherAgentLinux"
    type_handler_version = "1.4"
  }]
}

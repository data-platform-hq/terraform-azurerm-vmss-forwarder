variable "resource_group" {
  type        = string
  description = "The name of the resource group."
}

variable "location" {
  type        = string
  description = "The Azure Region in which resources would be created."
}

variable "load_balancer_name" {
  type        = string
  description = "Load Balancer name"
}

variable "vm_scale_set_name" {
  type        = string
  description = "VM Scale Set name"
}

variable "subnet_id" {
  type        = string
  description = "The ID of the Subnet where this Network first Interface should be located in."
}

variable "spoke_cidrs" {
  type        = list(string)
  description = "List of IP Address CIDRs that would be managed in Iptables configuration. Traffic would be forwarded between those networks."
  default     = []
}

variable "default_dns_server_ip_address" {
  type        = string
  description = "IP Address of the DNS Server that would resolve queries by default. Default value is an Azure DNS Server public ip"
  default     = "168.63.129.16"
}

variable "additional_dns_zones" {
  type = list(object({
    zone_name           = string
    server_ip_addresses = list(string)
  }))
  description = "List of objects to configure custom DNS zones. DNS Traffic would be forwarded to mentioned DNS Server IP Address in case zone name is matched in query"
  default     = []
}


variable "public_ip_prefix_enabled" {
  type        = string
  description = "Boolean flag that determines whether Public IP Address prefix is assigned to VMSS. By default it is disable because NAT Gateway is used for default outbound traffic."
  default     = false
}

variable "admin_username" {
  type        = string
  description = "VM Scale Set admin username"
  default     = "azureuser"
}

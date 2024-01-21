output "vmss_id" {
  value       = module.vmss.id
  description = "VM Scale Sets id"
}

output "lb_id" {
  value       = module.lb.lb_id
  description = "Load Balancer id"
}

output "lb_private_ip" {
  value       = module.lb.lb_private_ip_address
  description = "Load Balancer private ip address"
}

output "vmss_username" {
  value       = var.admin_username
  description = "VM Scale Sets admin username value"
}

output "vmss_password" {
  value       = random_password.this.result
  description = "VM Scale Sets admin password value"
}

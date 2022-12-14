output "client_secret" {
  description = "Secret password (client_secret) for the Service Principal."
  value       = module.terraform_cloud_service_principal.client_secret
  sensitive   = true
}

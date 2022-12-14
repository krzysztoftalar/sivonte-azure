output "client_secret" {
  description = "This is the secret password (client_secret) for the Service Principal."
  value       = module.service_principal.client_secret
  sensitive   = true
}

output "client_secret" {
  description = "This is the secret password (client_secret) for the Service Principal."
  value       = azuread_application_password.this.value
  sensitive   = true
}


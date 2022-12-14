locals {
  tags = tomap({
    "Owner"       = var.owner,
    "Environment" = var.environment,
    "Project"     = var.project,
    "Management"  = var.management,
  })
}

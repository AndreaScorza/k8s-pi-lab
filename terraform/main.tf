# modules will be added here
module "observability" {
  source = "./modules/observability"

  grafana_password = var.grafana_password
}
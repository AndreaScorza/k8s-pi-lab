# modules will be added here
module "observability" {
  source = "./modules/observability"

  grafana_password   = var.grafana_password
  telegram_bot_token = var.telegram_bot_token
  telegram_chat_id   = var.telegram_chat_id
}
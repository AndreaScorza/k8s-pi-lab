variable "grafana_password" {
  description = "Grafana administrator password"
  type        = string
  sensitive   = true
}

variable "telegram_bot_token" {
  description = "Telegram bot token used by Alertmanager to send notifications"
  type        = string
  sensitive   = true
}

variable "telegram_chat_id" {
  description = "Telegram chat ID that receives Alertmanager notifications"
  type        = string
}
variable "grafana_password" {
  type      = string
  sensitive = true
}

variable "telegram_bot_token" {
  type      = string
  sensitive = true
}

variable "telegram_chat_id" {
  type = string
}
variable "location" {
  description = "Regiunea Azure"
  type        = string
  default     = "westeurope"
}

variable "prefix" {
  description = "Prefix folosit pentru numele resurselor"
  type        = string
  default     = "catalab"
}

variable "vm_size" {
  description = "Dimensiunea VM-ului (B1s/B2s recomandat pentru creditul de student)"
  type        = string
  default     = "Standard_B2s"
}

variable "admin_username" {
  description = "User administrator Windows"
  type        = string
  default     = "azadmin"
}

variable "admin_password" {
  description = "Parola administrator Windows (min 12 caractere, complexă)"
  type        = string
  sensitive   = true
}

variable "my_ip" {
  description = "IP-ul tău public, ca RDP să fie deschis DOAR pentru tine (ex: \"93.14.x.x/32\")"
  type        = string
}

variable "file_share_quota_gb" {
  description = "Capacitatea share-ului de fișiere (GB)"
  type        = number
  default     = 32
}

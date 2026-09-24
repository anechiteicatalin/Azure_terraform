variable "location" {
  description = "Regiunea Azure"
  type        = string
  default     = "westeurope"
}

variable "prefix" {
  description = "Prefix folosit pentru numele resurselor"
  type        = string
  default     = "catalab"

  # Folosit în numele Storage Account (doar a-z0-9, max 24) și în numele
  # VM-ului Windows (max 15 caractere pentru computer name).
  validation {
    condition     = can(regex("^[a-z0-9]{1,12}$", var.prefix))
    error_message = "prefix trebuie să aibă 1-12 caractere, doar litere mici și cifre."
  }
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

  validation {
    condition     = length(var.admin_password) >= 12
    error_message = "admin_password trebuie să aibă minim 12 caractere."
  }
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

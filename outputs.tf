output "vm_public_ip" {
  description = "IP public pentru conectare RDP"
  value       = azurerm_public_ip.pip.ip_address
}

output "vm_name" {
  value = azurerm_windows_virtual_machine.vm.name
}

output "storage_account_name" {
  value = azurerm_storage_account.storage.name
}

output "file_share_name" {
  value = azurerm_storage_share.share.name
}

output "file_share_url" {
  description = "UNC path pentru montarea share-ului (ex: din interiorul VM-ului)"
  value       = "\\\\${azurerm_storage_account.storage.name}.file.core.windows.net\\${azurerm_storage_share.share.name}"
}

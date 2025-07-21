# provider "azurerm" {
#   features {}
# }

# variable "admin_username" {
#   description = "The admin username for the VM"
#   type        = string
# }

# variable "admin_password" {
#   description = "The admin password for the VM"
#   type        = string
#   sensitive   = true
# }

# resource "azurerm_resource_group" "alpha" {
#   name     = "alpha-resources"
#   location = "East US"
# }

# resource "azurerm_virtual_network" "alpha" {
#   name                = "alpha-vnet"
#   address_space       = ["10.0.0.0/16"]
#   location            = azurerm_resource_group.alpha.location
#   resource_group_name = azurerm_resource_group.alpha.name
# }

# resource "azurerm_subnet" "internal" {
#   name                 = "internal"
#   resource_group_name  = azurerm_resource_group.alpha.name
#   virtual_network_name = azurerm_virtual_network.alpha.name
#   address_prefixes     = ["10.0.2.0/24"]
# }

# resource "azurerm_network_interface" "alpha" {
#   name                = "alpha-nic"
#   location            = azurerm_resource_group.alpha.location
#   resource_group_name = azurerm_resource_group.alpha.name

#   ip_configuration {
#     name                          = "internal"
#     subnet_id                     = azurerm_subnet.internal.id
#     private_ip_address_allocation = "Dynamic"
#   }
# }

# resource "azurerm_network_security_group" "alpha" {
#   name                = "alpha-nsg"
#   location            = azurerm_resource_group.alpha.location
#   resource_group_name = azurerm_resource_group.alpha.name

#   security_rule {
#     name                       = "SSH"
#     priority                   = 1001
#     direction                  = "Inbound"
#     access                     = "Allow"
#     protocol                   = "Tcp"
#     source_port_range          = "*"
#     destination_port_range     = "22"
#     source_address_prefix      = "*"
#     destination_address_prefix = "*"
#   }
# }

# resource "azurerm_network_interface_security_group_association" "alpha" {
#   network_interface_id      = azurerm_network_interface.alpha.id
#   network_security_group_id = azurerm_network_security_group.alpha.id
# }

# resource "azurerm_public_ip" "alpha" {
#   name                = "alpha-pip"
#   location            = azurerm_resource_group.alpha.location
#   resource_group_name = azurerm_resource_group.alpha.name
#   allocation_method   = "Dynamic"
# }

# resource "azurerm_virtual_machine" "alpha" {
#   name                  = "alpha-vm"
#   location              = azurerm_resource_group.alpha.location
#   resource_group_name   = azurerm_resource_group.alpha.name
#   network_interface_ids = [azurerm_network_interface.alpha.id]
#   vm_size               = "Standard_B1ls"

#   storage_os_disk {
#     name              = "alpha-os-disk"
#     caching           = "ReadWrite"
#     create_option     = "FromImage"
#     managed_disk_type = "Standard_LRS"
#     disk_size_gb      = 30  # Minimum size for OS disk
#   }

#   storage_image_reference {
#     publisher = "Canonical"
#     offer     = "UbuntuServer"
#     sku       = "18.04-LTS"
#     version   = "latest"
#   }

#   os_profile {
#     computer_name  = "alpha-vm"
#     admin_username = var.admin_username
#     admin_password = var.admin_password
#   }

#   os_profile_linux_config {
#     disable_password_authentication = false
#   }

#   boot_diagnostics {
#     enabled     = true
#     storage_uri = azurerm_storage_account.alpha.primary_blob_endpoint
#   }
# }

# resource "azurerm_storage_account" "alpha" {
#   name                     = "adamsprojectstorageacc"
#   resource_group_name      = azurerm_resource_group.alpha.name
#   location                 = azurerm_resource_group.alpha.location
#   account_tier             = "Standard"
#   account_replication_type = "LRS"
# }

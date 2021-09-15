# Generate random text for a unique storage account name
# resource "random_id" "randomId" {
#     keepers = {
#         # Generate a new ID only when a new resource group is defined
#         resource_group = "${azurerm_resource_group.rg.name}"
#     }
    
#     byte_length = 8
# }

# Create storage account for boot diagnostics
# resource "azurerm_storage_account" "storageaccount" {
#     name                        = "diag${random_id.randomId.hex}"
#     resource_group_name         = "${azurerm_resource_group.rg.name}"
#     location                    = "eastus"
#     account_tier                = "Standard"
#     account_replication_type    = "LRS"

#     tags = var.tags
# }

# Create Azure Resource Group
resource "azurerm_resource_group" "bastion-rg" {
  name     = var.vm_resource_group_name ###
  location = var.location_extended ###

  tags = var.tags
}

# Create Bootstrap script from template
data "template_file" "bastion-bootstrap" {
  template = file("${path.module}/data/bootstrap.tpl")
  vars = {
    adminuser   = var.vm_profile_admin_username
    kube_config = azurerm_kubernetes_cluster.aks.kube_config_raw
  }
}

# Create virtual machine
resource "azurerm_linux_virtual_machine" "bastion-vm" {
  name                            = var.vm_name
  location                        = var.location
  resource_group_name             = azurerm_resource_group.bastion-rg.name
  network_interface_ids           = [azurerm_network_interface.bastion-nic.id]
  size                            = var.vm_size
  admin_username                  = var.vm_profile_admin_username
  computer_name                   = var.vm_name
  disable_password_authentication = var.vm_linux_disable_password_authentication
  custom_data                     = base64encode(data.template_file.bastion-bootstrap.rendered)
  lifecycle {
    ignore_changes = [custom_data]
  }

  os_disk {
    name                 = var.vm_disk_name
    caching              = var.vm_disk_caching
    storage_account_type = var.vm_disk_managed_disk_type
  }

  source_image_reference {
    publisher = var.vm_image_publisher
    offer     = var.vm_image_offer
    sku       = var.vm_image_sku
    version   = var.vm_image_version
  }

  admin_ssh_key {
    username   = var.vm_profile_admin_username
    public_key = file("${path.module}/data/vm_key.pub")
  }

  # boot_diagnostics {
  #     enabled                 = "true"
  #     storage_uri             = "${azurerm_storage_account.storageaccount.primary_blob_endpoint}"
  # }

  tags = var.tags
}
data "azurerm_network_interface" "nic-data" {
    for_each = var.vm
  name                = each.value.name-nicdata
  resource_group_name = each.value.resource_group_name
}

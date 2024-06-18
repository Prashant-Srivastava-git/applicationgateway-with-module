data "azurerm_subnet" "datasubnet" {
    for_each = var.appgate
  name                 = each.value.name-nicdata
  virtual_network_name = each.value.virtual_network_name
  resource_group_name  = each.value.resource_group_name
}
data "azurerm_network_interface" "nic-data1" {
    for_each = var.appgate
  name                = each.value.name-nicdata1
  resource_group_name = each.value.resource_group_name
}
data "azurerm_network_interface" "nic-data2" {
    for_each = var.appgate
  name                = each.value.name-nicdata2
  resource_group_name = each.value.resource_group_name
}

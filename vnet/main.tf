resource "azurerm_virtual_network" "vnet" {
    for_each = var.vnet
    address_space = each.value.address_space
    location = each.value.location
    name = each.value.name
    resource_group_name = each.value.resource_group_name
    
}
resource "azurerm_network_interface" "nic" {
    for_each = var.nic
  name                = each.value.name-nic
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = data.azurerm_subnet.datasubnet[each.key].id
    private_ip_address_allocation = "Dynamic"
  }
}
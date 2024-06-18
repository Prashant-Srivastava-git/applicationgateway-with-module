resource "azurerm_subnet" "bastionsnet" {
    for_each = var.bastion
  name                 = each.value.name-snet
  resource_group_name  = each.value.resource_group_name
  virtual_network_name = each.value.virtual_network_name
  address_prefixes     = ["10.0.4.0/24"]
}

resource "azurerm_public_ip" "pip" {
    for_each = var.bastion
  name                = each.value.name-pip
  location            = each.value.location
  resource_group_name = each.value.resource_group_name
  allocation_method   = each.value.allocation_method
  sku                 = each.value.sku
}

resource "azurerm_bastion_host" "host" {
    for_each = var.bastion
  name                = each.value.name-host
  location            = each.value.location
  resource_group_name = each.value.resource_group_name

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.bastionsnet[each.key].id
    public_ip_address_id = azurerm_public_ip.pip[each.key].id
  }
}
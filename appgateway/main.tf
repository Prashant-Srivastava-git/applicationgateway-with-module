resource "azurerm_public_ip" "pipgate" {
  for_each = var.appgate
  name                = each.value.name-gatepip
  resource_group_name = each.value.resource_group_name
  location            = each.value.location
  allocation_method   = each.value.allocation_method
  sku = each.value.sku
}



resource "azurerm_application_gateway" "network" {
  for_each = var.appgate
  name                = each.value.name-apw
  resource_group_name = each.value.resource_group_name
  location            = each.value.location

  sku {
    name     = each.value.name-sku
    tier     = each.value.tier
    capacity = each.value.capacity
  }

  gateway_ip_configuration {
    name      = each.value.name-gateway_ip_configuration
    subnet_id = data.azurerm_subnet.datasubnet[each.key].id
  }

  frontend_port {
    name = each.value.name-frontend_port
    port = each.value.port
  }

  frontend_ip_configuration {
    name                 = each.value.name-frontend_ip_configuration
    public_ip_address_id = azurerm_public_ip.pipgate[each.key].id
  }

  backend_address_pool {
    name = each.value.backend_address_pool_name
  }

  backend_http_settings {
    name                  = each.value.backend_http_settings_name
    cookie_based_affinity = each.value.cookie_based_affinity
    path                  = each.value.path
    port                  = each.value.port
    protocol              = each.value.protocol
    request_timeout       = each.value.request_timeout
  }

  http_listener {
    name                           = each.value.name-http_listener
    frontend_ip_configuration_name = each.value.frontend_ip_configuration_name
    frontend_port_name             = each.value.frontend_port_name
    protocol                       = each.value.protocol
  }

  request_routing_rule {
    name                       = each.value.name-request_routing_rule
    priority                   = each.value.priority
    rule_type                  = each.value.rule_type
    http_listener_name         = each.value.http_listener_name
    backend_address_pool_name  = each.value.backend_address_pool_name
    backend_http_settings_name = each.value.backend_http_settings_name
  }
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "vm1" {
  for_each = var.appgate
  network_interface_id    = data.azurerm_network_interface.nic-data1[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = tolist(azurerm_application_gateway.network[each.key].backend_address_pool).0.id
}
resource "azurerm_network_interface_application_gateway_backend_address_pool_association" "vm2" {
  for_each = var.appgate
  network_interface_id    = data.azurerm_network_interface.nic-data2[each.key].id
  ip_configuration_name   = "internal"
  backend_address_pool_id = tolist(azurerm_application_gateway.network[each.key].backend_address_pool).0.id
}
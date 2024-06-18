rg = {
  rg1 = {
    name     = "rg"
    location = "east us"
  }
}
vnet = {
  vnet1 = {
    address_space       = ["10.0.0.0/16"]
    location            = "east us"
    name                = "vnet"
    resource_group_name = "rg"
  }
}
subnet = {
  subnet1 = {
    address_prefixes     = ["10.0.1.0/24"]
    name                 = "vm1-subnet"
    resource_group_name  = "rg"
    virtual_network_name = "vnet"
  }
  subnet2 = {
    address_prefixes     = ["10.0.2.0/24"]
    name                 = "vm2-subnet"
    resource_group_name  = "rg"
    virtual_network_name = "vnet"
  }
  subnet3 = {
    address_prefixes     = ["10.0.3.0/24"]
    name                 = "apw-subnet"
    resource_group_name  = "rg"
    virtual_network_name = "vnet"
  }
}
bastion = {
  bastion1 = {

    name-snet            = "AzureBastionSubnet"
    resource_group_name  = "rg"
    virtual_network_name = "vnet"

    name-pip          = "bastion-pip"
    allocation_method = "Static"
    sku               = "Standard"

    name-host = "bastion-host"
    location  = "east us"

  }

}
nic = {
  nic1 = {
    name-nic             = "vm1-nic"
    location             = "east us"
    resource_group_name  = "rg"
    name-nicdata         = "vm1-subnet"
    virtual_network_name = "vnet"

  }
  nic2 = {
    name-nic             = "vm2-nic"
    location             = "east us"
    resource_group_name  = "rg"
    name-nicdata         = "vm2-subnet"
    virtual_network_name = "vnet"

  }
}
vm = {
  vm1 = {
    name-vm             = "pkvm1"
    resource_group_name = "rg"
    location            = "east us"
    size                = "Standard_F2"
    admin_username      = "username1"
    admin_password      = "VDEG#fJ^*Ib"
    name-nicdata        = "vm1-nic"
  }
  vm2 = {
    name-vm             = "mkvm1"
    resource_group_name = "rg"
    location            = "east us"
    size                = "Standard_F2"
    admin_username      = "username1"
    admin_password      = "VD$^bJ^*Ib"
    name-nicdata        = "vm2-nic"
  }
}
appgate = {
  appgate1 = {
    name-gatepip = "pkgatepip"
  resource_group_name = "rg"
  location = "east us"
  allocation_method   = "Static"
  sku = "Standard"
  name-apw = "pkapw"
  
    name-sku = "Standard_v2"
    tier     = "Standard_v2"
    capacity = 2

    name-gateway_ip_configuration = "pkgateipconfig"
    
    name-frontend_port = "pkfrontport"
    port = 80
  
    name-frontend_ip_configuration = "pkfrontipconfig"
    

  
    backend_address_pool_name = "pkbackaddpool"

    backend_http_settings_name = "pkbackhttpset"
    cookie_based_affinity = "Disabled"
    path                  = "/path1/"
    port                  = 80
    protocol              =  "Http"
    request_timeout       = 60
    name-http_listener    = "pkhttplistener"
    frontend_ip_configuration_name = "pkfrontipconfig"
    frontend_port_name             = "pkfrontport"
    protocol                       = "Http"
  
    name-request_routing_rule   = "pkrouterule"
    priority                   = 9
    rule_type                  = "Basic"
    http_listener_name         = "pkhttplistener"
    backend_address_pool_name  = "pkbackaddpool"
    backend_http_settings_name = "pkbackhttpset"
    name-nicdata = "apw-subnet"
    name-nicdata1 = "vm1-nic"
    name-nicdata2 = "vm2-nic"
    virtual_network_name  = "vnet"
  }
}

module "resource" {
  source = "../../resource"
  rg     = var.rg
}
module "virtualnet" {
  source     = "../../vnet"
  vnet       = var.vnet
  depends_on = [module.resource]

}
module "subnet1" {
  source     = "../../subnet"
  subnet     = var.subnet
  depends_on = [module.virtualnet]
}
module "bastion" {
  source     = "../../bastion"
  bastion    = var.bastion
  depends_on = [module.resource]

}
module "nic" {
  source     = "../../nic"
  nic        = var.nic
  depends_on = [module.subnet1]

}
module "vm" {
  source     = "../../vm"
  vm         = var.vm
  depends_on = [module.nic]
}

module "appgatenew" {
  source = "../../appgateway"
  appgate = var.appgate
  
  
}
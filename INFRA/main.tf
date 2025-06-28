module "rg01"{
    source= "../MODULE/Azurerm_Resource_Group"
    rg_name="aslamrg"
    rg_location="westeurope"
}
module "vnet" {
    depends_on = [module.rg01  ]
    source = "../MODULE/Azurerm_Vnet"
    vnet_name = "aslamvnet"
    location = "westeurope"
    resource_group_name = "aslamrg"
    address_space = ["10.0.0.0/16"]
    }
module "subnet01" {
    depends_on = [module.vnet]
    source = "../MODULE/Azurerm_SUBNET"
    subnet_name= "frontendsubnet"
  resource_group_name  = "aslamrg"
  virtual_network_name = "aslamvnet"
  address_prefixes=["10.0.1.0/24"]
}
module "subnet02" {
    depends_on = [module.vnet]
    source =  "../MODULE/Azurerm_SUBNET"
    subnet_name= "backendsubnet"
  resource_group_name  = "aslamrg"
  virtual_network_name = "aslamvnet"
  address_prefixes=["10.0.2.0/24"]
}
module "fe-pip" {
  depends_on= [module.rg01]
  source="../MODULE/Azurerm_public_ip"
  pip_name = "frontend_pip"
  location = "westeurope"
  rg_name  = "aslamrg"
}
module "ba_pip" {
  depends_on= [module.rg01]
  source="../MODULE/Azurerm_public_ip"
  pip_name = "backend_pip"
  location = "westeurope"
  rg_name  = "aslamrg"
}
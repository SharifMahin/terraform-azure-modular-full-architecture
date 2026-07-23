resource "azurerm_private_endpoint" "pe" {
  name                = var.private_endpoint_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = var.pe_subnet_id
  tags                = var.tags

  private_service_connection {
    name                           = "${var.private_endpoint_name}-connection"
    private_connection_resource_id = var.storage_account_id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }
}

resource "azurerm_private_dns_zone" "dns_zone" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_link" {
  name                  = "${var.private_endpoint_name}-dns-link"
  resource_group_name   = var.resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.dns_zone.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_dns_a_record" "dns_record" {
  name                = var.storage_account_name
  zone_name           = azurerm_private_dns_zone.dns_zone.name
  resource_group_name = var.resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.pe.private_service_connection[0].private_ip_address]
}
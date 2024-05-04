resource "azurerm_resource_group" "example" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_cognitive_account" "example" {
  name                = var.cognitive_account_name
  location            = azurerm_resource_group.example.location
  resource_group_name = azurerm_resource_group.example.name
  kind                = "OpenAI"
  sku_name            = var.cognitive_account_sku
}

resource "azapi_resource" "content_filter" {
  type                      = "Microsoft.CognitiveServices/accounts/raiPolicies@2023-10-01-preview"
  name                      = var.content_filter_name
  parent_id                 = azurerm_cognitive_account.example.id
  schema_validation_enabled = false
  depends_on                = [azurerm_cognitive_account.example]

  body = jsonencode({
    properties = {
      mode           = var.content_filter_mode
      basePolicyName = var.content_filter_base_policy_name
      contentFilters = concat(var.content_filters, var.filter_config)
    }
  })
}

resource "azurerm_cognitive_deployment" "example" {
  name                 = var.deployment_name
  cognitive_account_id = azurerm_cognitive_account.example.id
  rai_policy_name      = azapi_resource.content_filter.name
  depends_on           = [azapi_resource.content_filter]

  model {
    format  = var.model_format
    name    = var.model_name
    version = var.model_version
  }

  scale {
    type = var.deployment_scale_type
  }
}

resource "azapi_resource" "blocklist" {
  type                      = "Microsoft.CognitiveServices/accounts/raiBlocklists@2023-10-01-preview"
  name                      = var.blocklist_name
  parent_id                 = azurerm_cognitive_account.example.id
  schema_validation_enabled = false
  depends_on                = [azapi_resource.content_filter]

  body = jsonencode({
    properties = {
      description = var.blocklist_description
    }
  })
}

resource "azapi_update_resource" "blocklist_item" {
    for_each = toset(local.blocklist_items)

    type                      = "Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview"
    resource_id               = "${azapi_resource.blocklist.id}/raiBlocklistItems/CustomBlockListTerm81${index(local.blocklist_items, each.key)}"
    depends_on                = [azapi_resource.blocklist]

    body = jsonencode({
        properties = {
            pattern = each.key
            isRegex = false
        }
    })
}

module "openai_deployment" {
  source = "./modules/openai_deployment"

  resource_group_name   = "example-rg"
  location              = "West Europe"
  cognitive_account_name = "example-cognitive-account"
  deployment_name        = "example-deployment"
  model_name             = "gpt-35-turbo"
  model_version          = "0301"
  content_filter_name    = "example-content-filter"

  content_filters = [
    { name = "hate",     blocking = true, enabled = true, allowedContentLevel = "High", source = "Prompt" },
    { name = "sexual",   blocking = true, enabled = true, allowedContentLevel = "High", source = "Prompt" },
    { name = "selfharm", blocking = true, enabled = true, allowedContentLevel = "High", source = "Prompt" },
    { name = "violence", blocking = true, enabled = true, allowedContentLevel = "High", source = "Prompt" },
    { name = "hate",     blocking = true, enabled = true, allowedContentLevel = "High", source = "Completion" },
    { name = "sexual",   blocking = true, enabled = true, allowedContentLevel = "High", source = "Completion" },
    { name = "selfharm", blocking = true, enabled = true, allowedContentLevel = "High", source = "Completion" },
    { name = "violence", blocking = true, enabled = true, allowedContentLevel = "High", source = "Completion" }
  ]

  filter_config = [
    { name = "jailbreak", blocking = true, enabled = true, source = "Prompt" },
    { name = "protected_material_text", blocking = true, enabled = true, source = "Completion" },
    { name = "protected_material_code", blocking = true, enabled = true, source = "Completion" }
  ]
  
  blocklist_name        = "example-blocklist"
  blocklist_description = "Example blocklist"
}
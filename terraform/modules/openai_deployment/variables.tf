variable "resource_group_name" {
  type        = string
  description = "The name of the resource group"
}

variable "location" {
  type        = string
  description = "The location of the resources"
}

variable "cognitive_account_name" {
  type        = string
  description = "The name of the Cognitive Services account"
}

variable "cognitive_account_sku" {
  type        = string
  description = "The SKU of the Cognitive Services account"
  default     = "S0"
}

variable "deployment_name" {
  type        = string
  description = "The name of the deployment"
}

variable "model_format" {
  type        = string
  description = "The format of the model"
  default     = "OpenAI"
}

variable "model_name" {
  type        = string
  description = "The name of the model"
}

variable "model_version" {
  type        = string
  description = "The version of the model"
}

variable "deployment_scale_type" {
  type        = string
  description = "The scale type of the deployment"
  default     = "Standard"
}

variable "content_filter_name" {
  type        = string
  description = "The name of the content filter"
}

variable "content_filter_mode" {
  type        = string
  description = "The mode of the content filter"
  default     = "Default"
}

variable "content_filter_base_policy_name" {
  type        = string
  description = "The base policy name of the content filter"
  default     = "Microsoft.Default"
}

variable "content_filters" {
  type        = list(object({
    name                = string
    blocking            = bool
    enabled             = bool
    allowedContentLevel = string
    source              = string
  }))
  description = "The content filters configuration"
}

variable "filter_config" {
  type        = list(object({
    name                = string
    blocking            = bool
    enabled             = bool
    source              = string
  }))
  description = "The content filters configuration"
}

variable "blocklist_name" {
  type        = string
  description = "The name of the blocklist"
}

variable "blocklist_description" {
  type        = string
  description = "The description of the blocklist"
}
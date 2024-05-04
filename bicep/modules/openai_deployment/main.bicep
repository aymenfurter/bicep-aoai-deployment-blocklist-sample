param location string

@description('The name of the Cognitive Services account')
param cognitiveAccountName string

@description('The SKU of the Cognitive Services account')
param cognitiveAccountSku string = 'S0'

@description('The name of the deployment')
param deploymentName string

@description('The format of the model')
param modelFormat string = 'OpenAI'

@description('The name of the model')
param modelName string

@description('The version of the model')
param modelVersion string

@description('The scale type of the deployment')
param deploymentScaleType string = 'Standard'

@description('The name of the content filter')
param contentFilterName string

@description('The mode of the content filter')
param contentFilterMode string = 'Default'

@description('The base policy name of the content filter')
param contentFilterBasePolicyName string = 'Microsoft.Default'

@description('The content filters configuration')
param contentFilters array

@description('The content filters configuration')
param filterConfig array

@description('The name of the blocklist')
param blocklistName string

@description('The description of the blocklist')
param blocklistDescription string

var blocklistItems = split(loadTextContent('../../blocklist_items.txt'), '\n')

resource cognitiveAccount 'Microsoft.CognitiveServices/accounts@2022-12-01' = {
  name: cognitiveAccountName
  location: location
  sku: {
    name: cognitiveAccountSku
  }
  kind: 'OpenAI'
}

resource contentFilter 'Microsoft.CognitiveServices/accounts/raiPolicies@2023-10-01-preview' = {
    name: contentFilterName
    parent: cognitiveAccount
    properties: {
        mode: contentFilterMode
        basePolicyName: contentFilterBasePolicyName
        contentFilters: concat(contentFilters, filterConfig)
        completionBlocklists: [
            {
                blocking: true
                blocklistName: blocklist.name
            }
        ]
        promptBlocklists: [
            {
                blocking: true
                blocklistName: blocklist.name
            }
        ]
    }
}

resource deployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: cognitiveAccount
  name: deploymentName 
  sku: {
    name: 'Standard'
    capacity: 30
  }
  properties: {
    model: {
      format: modelFormat
      name: modelName
      version: modelVersion
    }
    raiPolicyName: contentFilter.name
  }
}

resource blocklist 'Microsoft.CognitiveServices/accounts/raiBlocklists@2023-10-01-preview' = {
  name: blocklistName
  parent: cognitiveAccount
  properties: {
    description: blocklistDescription
  }
}

resource blocklistItems_resource 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = [for (item, index) in blocklistItems: {
  name: 'CustomBlockListTerm81${index}'
  parent: blocklist
  properties: {
    pattern: item
    isRegex: false
  }
}]
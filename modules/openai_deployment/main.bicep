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


resource blocklistItem1 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_001'
  parent: blocklist
  properties: {
    pattern: 'You shall not pass!'
    isRegex: false
  }
}

resource blocklistItem2 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_002'
  parent: blocklist
  properties: {
    pattern: 'Du kommst hier nicht rein'
    isRegex: false
  }
  dependsOn: [
    blocklistItem1
  ]
}

resource blocklistItem3 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_003'
  parent: blocklist
  properties: {
    pattern: 'Access Denied'
    isRegex: false
  }
  dependsOn: [
    blocklistItem2
  ]
}

resource blocklistItem4 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_004'
  parent: blocklist
  properties: {
    pattern: 'Unauthorized Entry'
    isRegex: false
  }
  dependsOn: [
    blocklistItem3
  ]
}

resource blocklistItem5 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_005'
  parent: blocklist
  properties: {
    pattern: 'This Way is Shut'
    isRegex: false
  }
  dependsOn: [
    blocklistItem4
  ]
}

resource blocklistItem6 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_006'
  parent: blocklist
  properties: {
    pattern: 'Keep Out'
    isRegex: false
  }
  dependsOn: [
    blocklistItem5
  ]
}

resource blocklistItem7 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_007'
  parent: blocklist
  properties: {
    pattern: 'Entry Prohibited'
    isRegex: false
  }
  dependsOn: [
    blocklistItem6
  ]
}

resource blocklistItem8 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_008'
  parent: blocklist
  properties: {
    pattern: 'Do Not Enter'
    isRegex: false
  }
  dependsOn: [
    blocklistItem7
  ]
}

resource blocklistItem9 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_009'
  parent: blocklist
  properties: {
    pattern: 'No Trespassing'
    isRegex: false
  }
  dependsOn: [
    blocklistItem8
  ]
}

resource blocklistItem10 'Microsoft.CognitiveServices/accounts/raiBlocklists/raiBlocklistItems@2023-10-01-preview' = {
  name: 'blocklistItem_010'
  parent: blocklist
  properties: {
    pattern: 'Forbidden Access'
    isRegex: false
  }
  dependsOn: [
    blocklistItem9
  ]
}

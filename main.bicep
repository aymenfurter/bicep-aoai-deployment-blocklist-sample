targetScope = 'subscription'

param resourceGroupName string = 'rg-we'
param location string = 'West Europe'

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

module openaiDeployment 'modules/openai_deployment/main.bicep' = {
  name: 'openaiDeployment'
  scope: resourceGroup
  params: {
    location: location
    cognitiveAccountName: 'example-cognitive-account'
    deploymentName: 'example-deployment'
    modelName: 'gpt-35-turbo'
    modelVersion: '0301'
    contentFilterName: 'example-content-filter'
    contentFilters: [
      {
        name: 'hate'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Prompt'
      }
      {
        name: 'sexual'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Prompt'
      }
      {
        name: 'selfharm'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Prompt'
      }
      {
        name: 'violence'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Prompt'
      }
      {
        name: 'hate'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Completion'
      }
      {
        name: 'sexual'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Completion'
      }
      {
        name: 'selfharm'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Completion'
      }
      {
        name: 'violence'
        blocking: true
        enabled: true
        allowedContentLevel: 'High'
        source: 'Completion'
      }
    ]
    filterConfig: [
      {
        name: 'jailbreak'
        blocking: true
        enabled: true
        source: 'Prompt'
      }
      {
        name: 'protected_material_text'
        blocking: true
        enabled: true
        source: 'Completion'
      }
      {
        name: 'protected_material_code'
        blocking: true
        enabled: true
        source: 'Completion'
      }
    ]
    blocklistName: 'example-blocklist'
    blocklistDescription: 'Example blocklist'
  }
}
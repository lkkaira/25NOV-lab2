

// bicep/main.bicep

targetScope = 'resourceGroup'
 
@description('Azure region for all resources.')

param location string = resourceGroup().location
 
@description('Storage account name (lowercase, 3–24 chars, globally unique).')

@minLength(3)

@maxLength(24)

param storageAccountName string
 
@description('Web App name (globally unique).')

param webAppName string
 
@description('App Service plan name.')

param planName string
 
@description('Plan SKU name (e.g., F1, B1, S1).')

@allowed(['F1','B1','B2','B3','S1','S2','S3'])

param planSkuName string = 'B1'
 
@description('Plan SKU tier (Free, Basic, Standard). Must match the SKU name.')

@allowed(['Free','Basic','Standard'])

param planSkuTier string = 'Basic'
 
module storage './modules/storageAccount.bicep' = {

  name: 'storageModule'

  params: {

    location: location

    storageAccountName: storageAccountName

    skuName: 'Standard_LRS'

    kind: 'StorageV2'

  }

}
 
module web './modules/webapp.bicep' ={

  name: 'webAppModule'

  params: {

    location: location

    webAppName: webAppName

    planName: planName

    skuName: planSkuName

    skuTier: planSkuTier

  }

  // Explicit dependency; simple and clear

  dependsOn: [

    storage

  ]

}
 
output storageAccountName string = storage.outputs.storageAccountName

output webAppUrl string = web.outputs.webAppUrl
 
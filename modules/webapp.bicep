

// bicep/modules/webApp.bicep
 
@description('Deployment location')

param location string
 
@description('Web App name (globally unique).')

param webAppName string
 
@description('App Service plan name.')

param planName string
 
@description('Plan SKU name, e.g., F1, B1, S1.')

@allowed(['F1','B1','B2','B3','S1','S2','S3'])

param skuName string = 'B1'
 
@description('Plan SKU tier. Must match the name (F1 -> Free, B1 -> Basic, S1 -> Standard).')

@allowed(['Free','Basic','Standard'])

param skuTier string = 'Basic'
 
resource plan 'Microsoft.Web/serverfarms@2022-09-01' = {

  name: planName

  location: location

  sku: {

    name: skuName

    tier: skuTier

    capacity: 1

  }

  kind: 'linux'

  properties: {

    reserved: true

  }

}
 
resource app 'Microsoft.Web/sites@2022-09-01' = {

  name: webAppName

  location: location

  properties: {

    serverFarmId: plan.id

    httpsOnly: true

  }

}
 
output webAppName string = app.name

output webAppUrl string = 'https://${app.name}.azurewebsites.net'

output planId string = plan.id
 
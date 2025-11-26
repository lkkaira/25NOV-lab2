

// bicep/modules/storageAccount.bicep
 
@description('Deployment location')

param location string
 
@description('Storage account name (lowercase letters and digits, 3–24 chars, globally unique).')

@minLength(3)

@maxLength(24)

param storageAccountName string
 
@description('Storage SKU')

@allowed([

  'Standard_LRS'

  'Standard_GRS'

  'Standard_RAGRS'

  'Standard_ZRS'

])

param skuName string = 'Standard_LRS'
 
@description('Storage Account kind')

@allowed(['StorageV2'])

param kind string = 'StorageV2'
 
resource sa 'Microsoft.Storage/storageAccounts@2023-01-01' = {

  name: storageAccountName

  location: location

  sku: {

    name: skuName

  }

  kind: kind

  properties: {

    minimumTlsVersion: 'TLS1_2'

    allowBlobPublicAccess: false

    supportsHttpsTrafficOnly: true

  }

}
 
output storageAccountName string = sa.name

output storageAccountId string = sa.id
 
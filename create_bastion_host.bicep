param location string = resourceGroup().location
param vnetName string
param bastionSubnetName string
param bastionHostName string

resource bastion 'Microsoft.Network/bastionHosts@2024-05-01' = {
  name: bastionHostName
  location: location
  sku: {
    name: 'Standard'
  }
  properties: {
    enableTunneling: true    
    ipConfigurations: [
      {
        name: 'ipconfig1'        
        properties: {
          subnet: {
            id: resourceId('Microsoft.Network/virtualNetworks/subnets', vnetName, bastionSubnetName)
          }
          publicIPAddress: {
            id: bastionPublicAddress.id
          } 
        }
      }
    ]
  }
}

resource bastionPublicAddress 'Microsoft.Network/publicIPAddresses@2023-05-01' = {
  name: 'bastionPublicIP'
  location: location
  sku: {
    name: 'Standard'
    tier: 'Regional'
  }
  properties: {
    publicIPAddressVersion: 'IPv4'
    publicIPAllocationMethod: 'Static'     
  }
}

output bastionHostName string = bastionHostName
// output bastionInfo object = {
//   value: {
//     name: bastion.name
//     location: bastion.location
//     subnetId: bastion.properties.ipConfigurations[0].properties.subnet.id
//   }
// }

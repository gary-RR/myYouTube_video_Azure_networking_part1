// Assign network contributor role to logged-in user

param principalId string                 // The principal ID of the user to assign the role to

// 'Contributor' role ID
var ContributorRole = 'b24988ac-6180-42a0-ab88-20f7382dd24c'  

// Assign "Network Contributor" to the user
resource contributorRoleAssignment 'Microsoft.Authorization/roleAssignments@2020-04-01-preview' = {
  name: guid('loggedinUser', principalId , ContributorRole)
  scope: resourceGroup()
  properties: {
    principalId: principalId 
    roleDefinitionId: subscriptionResourceId('Microsoft.Authorization/roleDefinitions', ContributorRole)
    principalType: 'User'
  }
}



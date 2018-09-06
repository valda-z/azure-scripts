# azure script library

## bash CLI scripts

## powershell scripts

Scripts are stored in subfolder `ps`.

#### assign AAD Security Group to Subscription and Role

This script is responsible for assigning AAD security group to Roles in Subscription.

Script name: `AddGroupToSubscription.ps1`

Parameters:
* `SubcriptionId` - optional (you can use subscription-id), if omitted than scripts will search all subscriptions and you can select right one
* `RoleName` - default value is `Billing Reader` but you can pass there any Role from Azure
* `GroupName` - Mandatory parameter, you have to pass there valid name of your security group

```powershell
.\AddGroupToSubscription.ps1 -GroupName 'My Group'
```

#### create Resource Group and assign AAD Security Groups to roles (Reader, Owner)

This script is responsible for creating Resource Group in Azure and assigning AAD security groups to Roles Reader and Owner for Resource Group.

Script name: `CreateResourceGroupAddGroups.ps1`

Parameters:
* `SubcriptionId` - optional (you can use subscription-id), if omitted than scripts will search all subscriptions and you can select right one
* `ResourceGroupName` -  mandatory - Name of Resource Group which will be created in selected subscription
* `ResourceGroupLocation` - mandatory - location for creating Resource Group (for example `westeurope`)
* `GroupNameReader` - Mandatory parameter, you have to pass there valid name of your security group which will be assigned to role Reader
* `GroupNameOwner` - Mandatory parameter, you have to pass there valid name of your security group which will be assigned to role Owner

```powershell
.\CreateResourceGroupAddGroups.ps1 -ResourceGroupName 'New Group' -ResourceGroupLocation 'westeurope' -GroupNameReader 'My Reader Group' -GroupNameOwner 'My Owner Group'
```

# ### parameters
param(
    # subscription ID 
    [string]$SubcriptionId='',

    # resource group name 
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupName,

    # resource group location 
    [Parameter(Mandatory=$true)]
    [string]$ResourceGroupLocation,

    # group name 
    [Parameter(Mandatory=$true)]
    [string]$GroupNameReader='',

    # group name 
    [Parameter(Mandatory=$true)]
    [string]$GroupNameOwner=''
)

# ### Main executing block

$roleReader="Reader"
$roleOwner="Owner"

# Login to Azure

# --== TODO: uncomment if needed ==-- 
#Login-AzureRmAccount

# collect subscription ID
if($SubcriptionId -eq '')
{

    # read subscription information
    $SubscriptionArr = (Get-AzureRmSubscription)

    do
    {

        cls
        Write-Host "================ Select Subscription ================"

        [int]$SubscriptionCount=0
        $SubscriptionArr | foreach {
            $SubscriptionCount+=1
            Write-Host $SubscriptionCount ": " $_.Name " / " $_.Id
        }
     
        Write-Host "Q: Press 'Q' to quit."
        $input = Read-Host "Please make a selection"
        if($input -eq 'q' -or $input -eq 'Q'){
            Write-Host 'Exiting script ...'
            exit
        }
        [int]$i = $input-1
        if(($i -ge 0) -and ($i -lt $SubscriptionCount)){
            $SubcriptionId = $SubscriptionArr[$i].Id
            $SubscriptionName = $SubscriptionArr[$i].Name
        }
    }
    until ($input -eq 'q' -or $SubcriptionId -ne '')
}

#change current subscription
Set-AzureRmContext -SubscriptionId $SubcriptionId

#create resource group
New-AzureRmResourceGroup -Name $ResourceGroupName -Location $ResourceGroupLocation

$grpIdReader = (Get-AzureRMADGroup -SearchString $GroupNameReader).Id
$grpIdOwner = (Get-AzureRMADGroup -SearchString $GroupNameOwner).Id

New-AzureRmRoleAssignment -ObjectId $grpIdReader -RoleDefinitionName $roleReader -ResourceGroupName $ResourceGroupName
New-AzureRmRoleAssignment -ObjectId $grpIdOwner -RoleDefinitionName $roleOwner -ResourceGroupName $ResourceGroupName

Write-Host ">> Group [" $GroupNameReader "] granted to role [" $roleReader "] for Resource Group: " $ResourceGroupName
Write-Host ">> Group [" $GroupNameOwner "] granted to role [" $roleOwner "] for Resource Group: " $ResourceGroupName


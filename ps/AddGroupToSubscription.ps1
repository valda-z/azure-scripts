# ### parameters
param(
    # subscription ID 
    [string]$SubcriptionId='',

    # role name
    [string]$RoleName='Billing Reader',

    # group name
    [Parameter(Mandatory=$true)]
    [string]$GroupName=''
)

# ### Main executing block

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

$subScope = "/subscriptions/"+$SubcriptionId

$grpId = (Get-AzureRMADGroup -SearchString $GroupName).Id

New-AzureRmRoleAssignment -ObjectId $grpId -RoleDefinitionName $RoleName -Scope $subScope


Write-Host ">> Group [" $GroupName "] granted to role [" $RoleName "] for subscription: " $SubscriptionName


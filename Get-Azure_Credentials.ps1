# Fill in the Name of the ServicePrincipal you just created and the subscription you want to use
$SPName = "GitHubUniverse"
$AzSubscriptionName = "MVP Subscription"

Connect-AzureAD

$Subscription = (Get-AzSubscription -SubscriptionName $AzSubscriptionName)
$ServicePrincipal = Get-AzADServicePrincipal -DisplayName $SPName
$AzureADApplication = Get-AzureADApplication -SearchString $SPName

$OutputObject = [PSCustomObject]@{
    clientId = $ServicePrincipal.ApplicationId
    clientSecret = (New-AzureADApplicationPasswordCredential -ObjectId $AzureADApplication.ObjectId).Value
    subscriptionId = $Subscription.Id
    tenantId = $Subscription.TenantId
}

$OutputObject | ConvertTo-Json
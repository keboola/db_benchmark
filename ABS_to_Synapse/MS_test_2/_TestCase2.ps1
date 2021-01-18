param(
    [Parameter(Mandatory=$false, HelpMessage="Azure Subscription ID")]
    [string]
    $SubscriptionId = "????????????????",

    [Parameter(Mandatory=$false, HelpMessage="Azure AD Tenant ID")]
    [string]
    $TenantId = "????????????????",

    [Parameter(Mandatory=$false, HelpMessage="The name of Azure Resource Group where SQL DW resides")]
    [string]
    $ResourceGroupName = "KBL",

    [Parameter(Mandatory=$false, HelpMessage="The name of Azure SQL Server where SQL DW resides")]
    [string]
    $ServerName = "kbltst01",

    [Parameter(Mandatory=$false, HelpMessage="The name of SQL Pool")]
    [string]
    $DatabaseName = "kbl01",

    [Parameter(Mandatory=$false, HelpMessage="SQL login")]
    [string]
    $UserName = "loaduser",

    [Parameter(Mandatory=$false, HelpMessage="The password for SQL login")]
    [string]
    $Password = "?????",

    [Parameter(Mandatory=$false, HelpMessage="The list of DWUs to be tested")]
    [array]
    $DWUs = @("500", "1000", "1500", "2000", "2500", "3000"),

    [Parameter(Mandatory=$false, HelpMessage="The flag indicating whether Synapse cache should be reset before running the tests")]
    [bool]
    $ClearCache = $false,

    [Parameter(Mandatory=$false, HelpMessage="The number of test iterations")]
    [int]
    $iterations = 3,

    [Parameter(Mandatory=$false, HelpMessage="The flag indicating whether SQL DW should be paused at the end of testing")]
    [bool]
    $Pause = $true
)


Start-Transcript -OutputDirectory $PSScriptRoot\results


if (!(Test-Path $PSScriptRoot\results))
{
    New-Item -Path $PSScriptRoot\results -ItemType Directory 
}

Connect-AzAccount -Subscription $subscriptionId -Tenant $tenantId


#Check Current Status
$DW = Get-AzSqlDatabase -DatabaseName $DatawareHouseName -ServerName $ServerName -ResourceGroupName $ResourceGroupName
# Resume DW
if($DW.Status -eq "Paused")
{
    Write-Host "Resuming data warehouse $DatawareHouseName"
    Resume-AzSqlDatabase -DatabaseName $DatawareHouseName -ResourceGroupName $ResourceGroupName -ServerName $ServerName
    Write-Host "Data warehouse $DatawareHouseName resumed successfully"
}

foreach ($DWU in $DWUs)
{
    $SLO = "DW" + $DWU + "c"
    Write-Host "Starting test for - $SLO"
    $DW = Get-AzSqlDatabase -DatabaseName $DatawareHouseName -ServerName $ServerName -ResourceGroupName $ResourceGroupName
    if ($DW.CurrentServiceObjectiveName -ne $SLO)
    {
        Write-Host "Scaling SQL DW - started" -ForegroundColor Yellow
        Set-AzSqlDatabase -RequestedServiceObjectiveName $SLO -DatabaseName $DatawareHouseName -ResourceGroupName $ResourceGroupName -ServerName $ServerName
        Write-Host "Scaling SQL DW - completed" -ForegroundColor Green
    }


    for ($i = 0; $i -lt $iterations; $i++)
    {
        Write-Host "Iteration #$i - started" -ForegroundColor Yellow
        Invoke-Sqlcmd -ServerInstance "$ServerName.database.windows.net" -Database $DatawareHouseName -UserName $UserName -Password $Password -Query "exec TestCase2 $DWU" #| Out-Null
        Write-Host "Iteration #$i - completed" -ForegroundColor Green
    }

}

if ($pause)
{
    Suspend-AzSqlDatabase -DatabaseName $DatawareHouseName -ResourceGroupName $ResourceGroupName -ServerName $ServerName
}

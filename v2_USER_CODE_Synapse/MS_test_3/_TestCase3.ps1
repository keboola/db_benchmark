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

    [Parameter(Mandatory=$false, HelpMessage="The name of Azure SQL Server where SQL Pool resides")]
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
    $Password = "",

    [Parameter(Mandatory=$false, HelpMessage="The list of DWUs to be tested")]
    [array]
    $DWUs = @("500", "1000", "1500", "2000", "2500", "3000"),

    [Parameter(Mandatory=$false, HelpMessage="The flag indicating whether Synapse cache should be reset before running the tests")]
    [bool]
    $ClearCache = $false,

    [Parameter(Mandatory=$false, HelpMessage="The number of test iterations")]
    [int]
    $iterations = 3
)


$ServerName = "kbltst01.database.windows.net"
$DatabaseName = "kbl01"
$UserName = "loaduser"
$Password = "pass@word1" 
$DWU = "1500"
$ClearCache = $false
$iterations = 1


Import-Module SqlServer


if (!(Test-Path $PSScriptRoot\results))
{
    New-Item -Path $PSScriptRoot\results -ItemType Directory 
}

Start-Transcript -OutputDirectory $PSScriptRoot\results

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


$timestamp = Get-Date -Format "yyyyMMdd-HHmmss"


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

    $resultfile = "$PSScriptRoot\results\AzureResults_$($DWU)_$timestamp.csv"

    "DWU,Query,Iteration,StartTime,FinishTime,Duration" | Out-File -FilePath $resultfile -Append

    for ($i = 0; $i -lt $iterations; $i++)
    {
        if ($ClearCache) {
            $clearCacheFile = "$PSScriptRoot\_ClearCache.sql"
            Invoke-Sqlcmd -ServerInstance "$ServerName.database.windows.net" -Database $DatabaseName -UserName $UserName -Password $Password -InputFile $clearCacheFile #| Out-Null
        }

        $warmupfiles = Get-ChildItem $PSScriptRoot\Microsoft_sql -Filter warmup_*.sql | Sort-Object -Property Name
        $queryfiles = Get-ChildItem $PSScriptRoot\Microsoft_sql -Filter query*.sql | Sort-Object -Property Name

        foreach ($warmupfile in $warmupfiles)
        {
            Write-Host "Warmup $warmupfile" -ForegroundColor Yellow
            $t1 = Get-Date
            Invoke-Sqlcmd -ServerInstance "$ServerName.database.windows.net" -Database $DatabaseName -UserName $UserName -Password $Password -InputFile $warmupfile.FullName | Out-Null
            $t2 = (Get-Date) - $t1
        }


        foreach ($queryfile in $queryfiles)
        {
            Write-Host "Iteration $i, query $queryfile started" -ForegroundColor Yellow
            $t1 = Get-Date
            Invoke-Sqlcmd -ServerInstance "$ServerName.database.windows.net" -Database $DatabaseName -UserName $UserName -Password $Password -InputFile $queryfile.FullName | Out-Null
            $t2 = Get-Date
            #$duration = $t2-$t1
            $DWU + "," + $queryfile.Name+","+$i+","+$t1.ToString("HH:mm:ss.fff") + "," + $t2.ToString("HH:mm:ss.fff") + "," + ($t2-$t1).TotalSeconds | Out-File -FilePath $resultfile -Append

            Write-Host "Iteration $i, query $queryfile completed - $(($t2-$t1).TotalSeconds)" -ForegroundColor Green
        }
    }
}

if ($pause)
{
    Suspend-AzSqlDatabase -DatabaseName $DatawareHouseName -ResourceGroupName $ResourceGroupName -ServerName $ServerName
}


Stop-Transcript 
    
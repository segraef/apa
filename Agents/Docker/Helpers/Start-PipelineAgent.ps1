
$ADO_ORG = Read-Host "Azure DevOps Organization Name: "
$ADO_TOKEN = Read-Host "Azure DevOps Personal Access Token: "

$ADO_POOL = Read-Host "Azure DevOps Agent Pool Name (Default: Self-Hosted): "
if (!$ADO_POOL) {$ADO_POOL = 'Self-Hosted'}
$location = Read-Host "Location: (Default: West Europe )"
if (!$location) {$location = 'West Europe'}
$resourceGroup = Read-Host "Resource Group Name: (Default: apa-rg)"
if (!$resourceGroup) {$resourceGroup = 'vdc-devopsagents-rg'}
$containerNamePrefix = Read-Host "Containername Prefix (Default: apa): "
if (!$containerNamePrefix) {$containerNamePrefix = 'apa'}
$agentCount = Read-Host "Container Count (Default: 3): "
if (!$agentCount) {$agentCount = '3'}
$osContainer = Read-Host "Container Operating System (Debian, Ubuntu or ServerCore, Default: Ubuntu): "
if (!$osContainer) {$osContainer = 'Ubuntu'}
$osContainer = $osContainer.ToLower()
$osType = switch ($osContainer) {
    'debian' {'linux'}
    'ubuntu' {'linux'}
    'servercore' {'linux'}    
}

$RegistryName = Read-Host "Azure Container Registry Name: "
$RegistryKey = Read-Host "Azure Container Registry Key: "
$ADO_URL = "https://dev.azure.com/$ADO_ORG/"
$ADO_POOL_LINUX = $ADO_POOL
$imageLinux = "$RegistryName" + ".azurecr.io/ado/adoagent_$osContainer`:latest"
$RegistryCredentials= New-Object System.Management.Automation.PSCredential ("$RegistryName", (ConvertTo-SecureString "$RegistryKey" -AsPlainText -Force))
$container= @()
$envVars = @{
"AZP_URL"="$ADO_URL";
"AZP_TOKEN"="$ADO_TOKEN";
"AZP_POOL"="$ADO_POOL_LINUX"
}
New-AzResourceGroup $resourceGroup -Location $location -Force
for ($i=1; $i -le $agentCount; $i++) {
    $containerName = $containerNamePrefix + "00$i"
    Write-Output "Creating container $containerName ..."
    $envVars["AZP_AGENT_NAME"] = $containerName
    New-AzContainerGroup `
        -ResourceGroupName $resourceGroup `
        -Name "$containerName" `
        -Image "$imageLinux" `
        -RegistryCredential $RegistryCredentials `
        -Cpu 1 `
        -MemoryInGB 4 `
        -OsType $osType `
        -RestartPolicy OnFailure `
        -EnvironmentVariable $envVars
    $container += "$containerName"
}
Write-Output $container

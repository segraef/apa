$ADO_ORG = Read-Host "Azure DevOps Organization Name: "
$ADO_TOKEN = Read-Host "Azure DevOps Personal Access Token: "
$ADO_POOL = Read-Host "Azure DevOps Agent Pool (Windows): "
if (!$ADO_POOL) {$ADO_POOL = 'Self-Hosted'}

$ADO_URL = "https://dev.azure.com/$ADO_ORG/"

docker run -e ADO_URL=$ADO_URL -e ADO_TOKEN=$ADO_TOKEN -e ADO_POOL=$ADO_POOL apa_ubuntu
#docker run -e ADO_URL=$ADO_URL -e ADO_TOKEN=$ADO_TOKEN -e ADO_POOL=$ADO_POOL apa_sdebian
#docker run -e ADO_URL=$ADO_URL -e ADO_TOKEN=$ADO_TOKEN -e ADO_POOL=$ADO_POOL apa_servercore
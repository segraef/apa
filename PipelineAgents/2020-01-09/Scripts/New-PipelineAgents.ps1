# Requirements

## Docker

# 1. Build Docker Image (Make sure docker is set to Windows Containers and this docker build gets executed at your repository root)

$organization = Read-Host "Azure DevOps Organization Name: "
$url = "https://dev.azure.com/$organization/"
$token = Read-Host "Azure DevOps Personal Access Token: "
$agentPool = Read-Host "Azure DevOps Agent Pool (Default 'Self-Hosted'): "
if (!$agentPool) {$agentPool = 'Self-Hosted'}
New-Item ".token" -ItemType File -Value "$token"

docker build --rm -f "dockerfile" -t apa_ubuntu .
#docker build --rm -f "dockerfile" -t apa_debian .
#docker build --rm -f "dockerfile" -t apa_servercore .

Remove-Item ".token" -Force

# 2. Start and connect Container Agents

docker run -e AZP_URL="$url" -e AZP_TOKEN_FILE="/azp/.token" -e AZP_POOL="$agentPool" apa_ubuntu
# docker run -e AZP_URL="$url" -e AZP_TOKEN_FILE="/azp/.token" -e AZP_POOL="$agentPool" apa_debian
# docker run -e AZP_URL="$url" -e AZP_TOKEN_FILE="/azp/.token" -e AZP_POOL="$agentPool" apa_servercore
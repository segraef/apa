
$ACR_NAME = Read-Host "Azure Container Registry Name: "
$ACR_KEY = Read-Host "Azure Container Registry Key: "
$ACR_URL = "$ACR_NAME.azurecr.io"

# Docker Push to Azure Container Registry
docker login $ACR_URL --username $ACR_NAME --password $ACR_KEY

docker tag adoagent_ubuntu $ACR_URL/ado/adoagent_ubuntu
docker tag adoagent_ubuntu $ACR_URL/ado/adoagent_debian
docker tag adoagent_ubuntu $ACR_URL/ado/adoagent_servercore

docker push $ACR_URL/ado/adoagent_ubuntu
docker push $ACR_URL/ado/adoagent_debian
docker push $ACR_URL/ado/adoagent_servercore
$ACR_NAME = Read-Host "Azure Container Registry Name: "
$ACR_KEY = Read-Host "Azure Container Registry Key: "
$ACR_URL = "$ACR_NAME.azurecr.io"

# Docker Push to Azure Container Registry
docker login $ACR_URL --username $ACR_NAME --password $ACR_KEY
docker tag apa_servercore $ACR_URL/apa_ubuntu
docker push $ACR_URL/apa_ubuntu
#docker tag apa_servercore $ACR_URL/apa_debian
#docker push $ACR_URL/apa_debian
#docker tag apa_servercore $ACR_URL/apa_servercore
#docker push $ACR_URL/apa_servercore
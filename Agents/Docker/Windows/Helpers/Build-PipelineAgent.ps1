$here = (Get-Location).Path

# Make sure docker is set to Windows Containers

docker build --rm -f "$here/Agents/Docker/Linux/ServerCore/dockerfile" -t devopsagent_servercore:latest .
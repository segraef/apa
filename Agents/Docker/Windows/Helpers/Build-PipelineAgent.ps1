# Make sure docker is set to Windows Containers and this docker build gets executed at your repository root.

docker build --rm -f "Agents/Docker/Windows/ServerCore/dockerfile" -t devopsagent_servercore:latest .
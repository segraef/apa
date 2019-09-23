$here = (Get-Location).Path

# Make sure docker is set to Linux Containers

docker build --rm -f "$here/Agents/Docker/Linux/Ubuntu/dockerfile" -t devopsagent_ubuntu:latest .
docker build --rm -f "$here/Agents/Docker/Linux/Debian/dockerfile" -t devopsagent_debian:latest .
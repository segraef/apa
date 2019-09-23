# Make sure docker is set to Linux Containers and this docker build gets executed at your repository root.

docker build --rm -f "Agents/Docker/Linux/Ubuntu/dockerfile" -t devopsagent_ubuntu:latest .
docker build --rm -f "Agents/Docker/Linux/Debian/dockerfile" -t devopsagent_debian:latest .
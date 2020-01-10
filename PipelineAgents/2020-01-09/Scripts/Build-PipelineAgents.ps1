# Make sure docker is set to Windows Containers and this docker build gets executed at your repository root.

docker build --rm -f "PipelineAgents/2020-01-09/dockerfile" -t devopsagent_ubuntu .
#docker build --rm -f "PipelineAgents/2020-01-09/dockerfile" -t devopsagent_debian .
#docker build --rm -f "PipelineAgents/2020-01-09/dockerfile" -t devopsagent_servercore .
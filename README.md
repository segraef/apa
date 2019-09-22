# Azure DevOps Pipelines Docker Agents (Self-Hosted)
## Overview
I'll be brief. The following explains how to build, setup and run self-hosted docker agents using Azure Pipelines in Azure DevOps (ADO). The pipeline does the following for you:

1. Build Docker Container Image for self-hosted Azure Pipelines Agent.
2. Push Docker Container Image to Azure Container Registry.
3. Start Docker Container as Azure Container Instance.
4. Connect Container to Azure DevOps Agent Pool (Self-Hosted).

## Container Agents
The docker container are based on the official [Azure Pipelines VM images for Microsoft-hosted CI/CD](https://github.com/microsoft/azure-pipelines-image-generation).

- [Ubuntu](Agents/Docker/Linux/Ubuntu) (latest)
- [Debian](Agents/Docker/Linux/Debian) (latest)
- [Server Core](Agents/Docker/Windows/ServerCore) (latest)

## Requirements

- Azure Container Registry
- Azure DevOps Project
- Azure DevOps preview feature [multi-stage pipelines](https://docs.microsoft.com/en-us/azure/devops/project/navigation/preview-features?view=azure-devops)
- Azure Resource Manager Service Connection

## Setup

1. Create an [Azure DevOps Agent pool](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops#creating-agent-pools) and clone/for this repo into it.

2. Generate a [Personal Access Token (PAT)](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops#create-personal-access-tokens-to-authenticate-access) for your Azure DevOps Organization. When generating the Personal Access Token (PAT), assign the following scopes:

- Agent Pools - Read & Manage
- Deployment Groups - Read & Manage

3. In pipeline/library add a variable group named vg.DevOpsAgent, with the following variables

    ```
    acrKey = <acrKey> # azure container registry key to login
    acrName = <acrKey> # azure container registry name
    adoUrl = https://dev.azure.com/<your_org> # Azure DevOps Organization URL
    agentCount = 3 # amount of azure pipeline container instances to be created
    agentPool = Self-Hosted # agent-pool name
    agentPoolToken = <acrKey>
    containerNamePrefix = apa
    location = westeurope  # where your resources will be created
    resourceGroup = apa-rg # where your agents will be placed
    serviceConnection = <serviceConnection> # arm service connection name
    vmImageLinux = ubuntu-latest # vm poolimage for linux containers
    vmImageWindows = windows-latest # vm poolimage for linux containers
    ```
4. Create a new pipeline using one of the following pipeline.yaml for [Ubuntu](Agents\Docker\Linux\Ubuntu\Pipeline\pipeline.yaml), for [Debian](Agents\Docker\Linux\Debian\Pipeline\pipeline.yaml) or for [Server Core](Agents\Docker\Linux\Debian\Pipeline\pipeline.yaml) and run it.

## Helpers

Instead using an Azure Pipeline you can also run also these tasks locally. For that you can find Helpers [here](Agents/Docker/Helpers). If you're not familiar with Docker at all I recommend the [Docker Quickstart](https://docs.docker.com/get-started/).



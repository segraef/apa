# Azure Pipelines Container Agents (Self-Hosted) for Azure DevOps
## Overview
I'll be brief. The following explains how to easily build, setup and run self-hosted docker container agents using Azure Pipelines in Azure DevOps (ADO). The pipeline does the following for you:

1. Creates an Azure Container Registry (ACR).
2. Builds Docker Container Image for self-hosted Azure Pipelines Agent within that ACR.
3. Starts Docker Container as Azure Container Instance (ACI).
4. Connects Docker Container to your Azure DevOps Agent Pool (Self-Hosted).

## Container Agents
The docker container are based on the official [Azure Pipelines VM images for Microsoft-hosted CI/CD](https://github.com/microsoft/azure-pipelines-image-generation).


| Container Agent | Tools | Build Status |
|---|---|---|
| [Ubuntu](PipelineAgents/2020-01-09/dockerfile) (latest)   | See [here](#Image-Contents) | [![Build Status](https://dev.azure.com/GeekClub/Public/_apis/build/status/PipelineAgents?branchName=master)](https://dev.azure.com/GeekClub/Public/_build/latest?definitionId=44&branchName=master) |
| [Debian](PipelineAgents/2020-01-09/dockerfile) (latest)  | See [here](#Image-Contents) |[![Build Status](https://dev.azure.com/GeekClub/Azure/_apis/build/status/Agents/DevOpsAgentDebian?branchName=master)](https://dev.azure.com/GeekClub/Azure/_build/latest?definitionId=28&branchName=master) |
|  [Server Core](PipelineAgents/2020-01-09/dockerfile_Servercore) (latest) | See [here](#Image-Contents) |[![Build Status](https://dev.azure.com/GeekClub/Azure/_apis/build/status/Agents/DevOpsAgentServerCore?branchName=master)](https://dev.azure.com/GeekClub/Azure/_build/latest?definitionId=28&branchName=master) |

## Requirements

- Azure [DevOps Project](https://docs.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=preview-page)
- Azure DevOps preview feature [multi-stage pipelines](https://docs.microsoft.com/en-us/azure/devops/project/navigation/preview-features?view=azure-devops) enabeld 
- Azure Resource Manager [Service Connection](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)

## Setup

1. Create an [Azure DevOps Agent pool](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops#creating-agent-pools) and clone/fork [this repo](https://github.com/segraef/apa.git) into it.

2. Generate a [Personal Access Token (PAT)](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops#create-personal-access-tokens-to-authenticate-access) for your Azure DevOps Organization. When generating the (PAT), assign the following scopes:

- Agent Pools - Read & Manage
- Deployment Groups - Read & Manage

3. In Pipelines/Library add a variable group named vg.PipelineAgents, with the following variable to avoid exposing keys & secrets in code

    ```
    agentPoolToken      = <agentPoolToken>      # personal acces token for agent pool

    ```

4. In your parameters.yml adjust following variables

    ```
    adoUrl              = https://dev.azure.com/<organization>  # Azure DevOps Organization URL
    agentPool           = <resourceGroup>                       # agent-pool name
    location            = <resourceGroup>                       # where your resources will be created
    resourceGroup       = <resourceGroup>                       # where your agents will be placed
    serviceConnection   = <serviceConnection>                   # arm service connection name
    ```

4. Create a new pipeline using your [pipeline.yaml](PipelineAgents/2020-01-09/Pipeline/pipeline.yml) for and run it.

## Helpers

Instead using an Azure Pipeline you can also run also these tasks locally. For that you can find Helpers [here](Agents/Docker/Linux/Helpers) (Linux) and [here](Agents/Docker/Windows/Helpers) (Windows). If you're not familiar with Docker at all I recommend the [Docker Quickstart](https://docs.docker.com/get-started/).

## Image Contents
### Ubuntu / Debian
- Azure CLI (latest)
- Git (latest)
- PowerShell Core (latest)
- .NET SDK (2.1)
- Docker (18.06).3-ce
- Kubectl (1.14.4)
- Terraform (0.12.6)

### Windows Server Core (ltsc2019)

- Chocolatey (latest)
- Azure CLI (latest)
- Git (latest)
- PowerShell Core (latest)
- Docker (in porgress)
- Kubectl (in porgress)
- Terraform (in porgress)



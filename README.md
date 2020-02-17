# Azure Pipelines Container Agents (Self-Hosted) for Azure DevOps

| Pipeline | Build Status |
|---|---|
| PipelineAgents | [![Build Status](https://dev.azure.com/GeekClub/Azure%20(Public)/_apis/build/status/PipelineAgents?branchName=master)](https://dev.azure.com/GeekClub/Azure%20(Public)/_build) |

## Overview
The following explains how to easily build, setup and run self-hosted docker container agents using Azure Pipelines in Azure DevOps (ADO). The pipeline does the following for you:

1. Creates an Azure Container Registry (ACR).
2. Builds Docker Container Image for self-hosted Azure Pipelines Agent within that ACR.
3. Starts Docker Container as Azure Container Instances (ACI).
4. Connects ACIs to your Azure DevOps Agent Pool (Self-Hosted).

## Requirements

- Azure [DevOps Project](https://docs.microsoft.com/en-us/azure/devops/organizations/projects/create-project?view=azure-devops&tabs=preview-page)
- Azure DevOps preview feature [multi-stage pipelines](https://docs.microsoft.com/en-us/azure/devops/project/navigation/preview-features?view=azure-devops) enabeld 
- Azure Resource Manager [Service Connection](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/service-endpoints?view=azure-devops&tabs=yaml)

## Setup

1. Create an [Azure DevOps Agent pool](https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/pools-queues?view=azure-devops#creating-agent-pools) within your Azure DevOps organization.

2. Generate a [Personal Access Token (PAT)](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops#create-personal-access-tokens-to-authenticate-access) for your Azure DevOps Organization. When generating the (PAT), assign the following scopes:

   - Agent Pools - Read & Manage
   - Deployment Groups - Read & Manage

3. Create a new repository and clone/fork [this repo](https://github.com/segraef/apa.git) into it.

4. In Pipelines/Library add a [variable group](https://docs.microsoft.com/en-us/azure/devops/pipelines/library/variable-groups?view=azure-devops&tabs=yaml) named vg.PipelineAgents, with the following variable to avoid exposing keys & secrets in code

    ```
    agentPoolToken      = <agentPoolToken>      # personal acces token for agent pool
    ```

5. In [parameters.yml](PipelineAgents/2020-01-09/Parameters/parameters.yml) adjust following variables

    ```
    acrName             = <acrName>                             # Container Registry Name (must be unique)
    adoUrl              = https://dev.azure.com/<organization>  # Azure DevOps Organization URL
    agentPool           = <agentPool>                           # agent-pool name
    location            = <location>                            # where your resources will be created
    resourceGroupName   = <resourceGroupName>                   # where your agents will be placed
    serviceConnection   = <serviceConnection>                   # arm service connection name
    ```

5. Create a new pipeline using the [pipeline.yaml](PipelineAgents/2020-01-09/Pipeline/pipeline.yml) and run it.

## Helpers

Instead using an Azure Pipeline you can also run also these tasks locally using your local machine as agent. For that you can find a Helper file [here](PipelineAgents/2020-01-09/Scripts/New-PipelieAgents.ps1). If you're not familiar with Docker at all I recommend the [Docker Quickstart](https://docs.docker.com/get-started/).

## Docker Container image contents

The docker container images are based on the official [Azure Pipelines VM images for Microsoft-hosted CI/CD](https://github.com/microsoft/azure-pipelines-image-generation).

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

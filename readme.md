# GitOps - Deploy Open Policy Agent

## How to

> If you cant see "Use this template" button, login with your github account

Deploy:

[Create a repository from a template](https://docs.github.com/en/github/creating-cloning-and-archiving-repositories/creating-a-repository-on-github/creating-a-repository-from-a-template#creating-a-repository-from-a-template)

`git clone your_repo_here`

`cd ~/your_repo_here`

`make`

### Prerequisites

1. Docker for Desktop

### Overview

Gitops template for Open Policy Agent policies development.

This template will:

- Create a local K8s cluster, using k3d.

  - Install ArgoCD.

    - Install ELK stack for monitoring

    - Install Open Policy Agent Gatekeeper and deploy the first policy.

![image](https://user-images.githubusercontent.com/40946247/125950496-0d9f804b-00cb-49df-8314-ca9cd52d7d97.png)

`make` targets step by step:

1. **validate_code:** Run `github-linter` locally and validate code (docker container)

2. **prepare_cluster:** Install all necessary packages and create a K3d cluster

3. **install_argocd:** Install ArgoCD and all the argocd applications (OPA, ELK, etc.).

4. **port_forward_argocd:** Access argocd in `localhost:8080`

After deployment you will have a K3d cluster with an active ArgoCD installation, Open Policy Agent Gatekeeper and ELK stack for logs and metrics.

**To access ArgoCD:**

- Check CLI output for ArgoCD UI password.

- In your browser ==> `localhost:8080`

**To access Kibana:**

- In a new terminal: `kubectl port-forward deployment/kibana-kibana 5601 -n monitoring`

- In your browser ==> `localhost:5601`

In `Management` ==> `Kibana` ==> `Index patterns`, create the index pattern using the 2 available indexes.

Check `Logs` and `Metrics` for available data, add filters to `Discover` for data filtering.

### OPA policies

Open Policy Agent policies located at `k8s/opa_gatekeeper/` directory.

### Cleanup

`make clean`

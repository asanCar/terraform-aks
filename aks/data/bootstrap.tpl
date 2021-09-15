#!/usr/bin/env sh

# Upgrade software & Install curl
sudo su admin
sudo apt-get update
sudo apt-get upgrade -y
sudo apt-get install -y ca-certificates curl apt-transport-https lsb-release gnupg

# Install kubectl
curl -LO https://storage.googleapis.com/kubernetes-release/release/`curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt`/bin/linux/amd64/kubectl
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

# Install Azure CLI
curl -sL https://packages.microsoft.com/keys/microsoft.asc | 
    gpg --dearmor | 
    sudo tee /etc/apt/trusted.gpg.d/microsoft.asc.gpg > /dev/null
AZ_REPO=$(lsb_release -cs)
echo "deb [arch=amd64] https://packages.microsoft.com/repos/azure-cli/ $AZ_REPO main" | 
    sudo tee /etc/apt/sources.list.d/azure-cli.list
sudo apt-get update
sudo apt-get install azure-cli

# Create ./kube/config
mkdir -p /home/${adminuser}/.kube/
echo "${kube_config}" > /home/${adminuser}/.kube/config

# Add kubectl autocompletion
echo "source <(kubectl completion bash)" >> ~/.bashrc

# Add helm 3 
sudo snap install helm --classic
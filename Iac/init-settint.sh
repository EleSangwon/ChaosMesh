#!/bin/bash
echo " ======================== Install kubectl ========================"
sudo curl --silent --location -o /usr/local/bin/kubectl\
https://amazon-eks.s3.us-west-2.amazonaws.com/1.21.2/2021-07-05/bin/linux/amd64/kubectl
sudo chmod +x /usr/local/bin/kubectl
sudo yum install -y jq
sudo yum install -y bash-completion
kubectl version --short --client
sleep 5

echo " ======================== Install awscli2 ========================"
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
aws --version
sleep 5

echo " ======================== Install eksctl ========================"
curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /tmp
sudo mv /tmp/eksctl /usr/local/bin
eksctl version

echo " ======================== Install helm ========================"
curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3
chmod 700 get_helm.sh
./get_helm.sh
helm version

echo " ======================== Install ChaosMesh ========================"
helm repo add chaos-mesh https://charts.chaos-mesh.org
helm search repo chaos-mesh
kubectl create ns chaos-testing

echo " ======================== Verify the installation ========================"
kubectl get po -n chaos-testing
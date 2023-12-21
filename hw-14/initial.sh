# create EC2 eks-manager with t2.micro

sudo -i
apt update

apt install unzip

curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
ls -a

unzip awscliv2.zip

./aws/install

aws configure

#to check that aws is properly configured
aws ec2 describe-instances

curl --silent --location -o /usr/local/bin/kubectl https://s3.us-west-2.amazonaws.com/amazon-eks/1.22.6/2022-03-09/bin/linux/amd64/kubectl

chmod +x /usr/local/bin/kubectl

curl --silent --location "https://github.com/weaveworks/eksctl/releases/latest/download/eksctl_$(uname -s)_amd64.tar.gz" | tar xz -C /usr/local/bin
ls -la

#mv /tmp/eksctl /usr/local/bin

#check that eksctl works
eksctl version

curl -fsSL -o get_helm.sh https://raw.githubusercontent.com/helm/helm/master/scripts/get-helm-3
ls -la

chmod 700 get_helm.sh

./get_helm.sh
helm version

eksctl create cluster --name eks-14 --region us-east-1 --nodegroup-name eks-ng --node-type t3.small --managed --nodes 2 --nodes-min 2 --nodes-max 3

eksctl get cluster --name eks-14 --region us-east-1

aws eks update-kubeconfig --name eks-14 --region us-east-1

kubectl get nodes #maybe will need to change user

helm repo add stable https://charts.helm.sh/stable
helm repo add prometheus-community https://prometheus-community.github.io/helm-charts

kubectl create namespace prometheus

helm install stable prometheus-community/kube-prometheus-stack -n prometheus

kubectl --namespace prometheus get pods

kubectl describe pods prometheus-stable-kube-prometheus-sta-prometheus-0 -n prometheus

kubectl get svc -n prometheus

kubectl edit svc stable-kube-prometheus-sta-prometheus -n prometheus # type: ClusterIP -> LoadBalancer

kubectl get svc -n prometheus #smth changed - External IP:9090 -> prometheus

kubectl edit svc stable-grafana -n prometheus # type: ClusterIP -> LoadBalancer

kubectl get svc -n prometheus #smth changed - External IP -> grafana

# get
kubectl get secrets -n prometheus stable-grafana
kubectl get secrets -n prometheus stable-grafana -o jsonpath="{.data.admin-password}" | base64 --decode
#login with it into grafana as 'admin'

#open grafana and import dashboard 15760

#create deployment.yml
kubectl apply -f deployment.yml

kubectl get svc

eksctl delete cluster --name eks-14

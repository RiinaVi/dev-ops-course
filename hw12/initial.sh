#in Master
sudo hostnamectl set-hostname "k8smaster"

#in Worker
#sudo hostnamectl set-hostname "k8sworker"

#in Both
exec bash

sudo tee --append /etc/hosts << EOF
54.87.95.162 k8smaster
52.55.238.139 k8sworker
EOF

sudo swapoff -a
sudo sed -i '/ swap / s/^\(.*\)$/#\1/g' /etc/fstab

sudo tee /etc/modules-load.d/containerd.conf <<EOF
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

sudo tee /etc/sysctl.d/kubernetes.conf <<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
net.ipv4.ip_forward = 1
EOF

sudo sysctl --system

sudo apt update

sudo apt install -y curl gnupg2 software-properties-common apt-transport-https ca-certificates

sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/docker.gpg
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt update
sudo apt install -y containerd.io

containerd config default | sudo tee /etc/containerd/config.toml >/dev/null 2>&1

sudo sed -i 's/SystemdCgroup \= false/SystemdCgroup \= true/g' /etc/containerd/config.toml

sudo systemctl restart containerd.service
sudo systemctl enable containerd.service

curl -s https://packages.cloud.google.com/apt/doc/apt-key.gpg | sudo gpg --dearmour -o /etc/apt/trusted.gpg.d/kubernetes-xenial.gpg
sudo apt-add-repository "deb http://apt.kubernetes.io/ kubernetes-xenial main"

sudo apt update

sudo apt install -y kubelet kubeadm kubectl

sudo apt-mark hold kubelet kubeadm kubectl

#in Master
sudo kubeadm init

mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

kubectl get nodes

#in Worker
sudo kubeadm join 172.31.88.94:6443 --token f5oy55.zd0b4e7a2ri60w7u \
        --discovery-token-ca-cert-hash sha256:b7d034cd32b8add26a571ce7950d4f0c45bf7eb213ff7127eca046d620d6c1e1

# in Master
kubectl apply -f https://raw.githubusercontent.com/projectcalico/calico/v3.25.0/manifests/calico.yaml

#create nginx deployment
kubectl create deployment nginx-app --image=nginx --replicas=2
kubectl expose deployment nginx-app --type=NodePort --port=80
kubectl get svc nginx-app

#create secret
kubectl create secret generic mysql-secret --from-literal=mysql-user=admin --from-literal=mysql-password=passpord123

#create namespace
kubectl create namespace riinavi-namespace

#create mysql deployment
kubectl run mysql-deployment --image=mysql:latest --env="MYSQL_ROOT_PASSWORD=$(kubectl get secret mysql-secret -o=jsonpath='{.data.mysql-password}' | base64 --decode)" --env="MYSQL_DATABASE=mydb" --env="MYSQL_USER=$(kubectl get secret mysql-secret -o=jsonpath='{.data.mysql-user}' | base64 --decode)" --env="MYSQL_PASSWORD=$(kubectl get secret mysql-secret -o=jsonpath='{.data.mysql-password}' | base64 --decode)"

#connect to pod
kubectl exec --stdin --tty mysql-deployment -- /bin/bash
mysql -p

#delete everything
kubectl delete all --all
kubectl delete namespace riinavi-namespace

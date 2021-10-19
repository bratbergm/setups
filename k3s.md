# k3s



**"DNS"**

sudo nano /etc/hosts

```bash
10.0.0.50 k3s-master
10.0.0.51 k3s-worker0
10.0.0.52 k3s-worker1
```

**ssh**

```bash
ssh-keygen
ssh-copy-id username@<server_IP>
```



**Docker**

```bash
sudo apt update

sudo apt install apt-transport-https ca-certificates curl software-properties-common -y
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu focal stable"

sudo apt update
sudo apt install docker-ce -y

sudo systemctl start docker
sudo systemctl enable docker

sudo usermod -aG docker ${USER}
newgrp docker

sudo systemctl status docker
```



**Master**

```
curl -sfL https://get.k3s.io | sh -s - --docker

sudo systemctl status k3s

sudo kubectl get nodes -o wide
```


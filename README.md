# mu3e-docker-setup

# Docker installation on Windows: 
[Full instructions on installing docker with wsl2 on windows](https://docs.docker.com/docker-for-windows/wsl/)  
- Virtualization must be activated in BIOS / UEFI
- At least. 4 GB RAM is required (> 8GB recommended)

## Install wsl 2
1. **Enable the required features**  
*Powershell:*
```
dism.exe /online /enable-feature /featurename:Microsoft-Windows-Subsystem-Linux /all /norestart
dism.exe /online /enable-feature /featurename:VirtualMachinePlatform /all /norestart
```

2. **Restart your PC**

3. Download and run the wsl2 kernel update [download here](https://wslstorestorage.blob.core.windows.net/wslblob/wsl_update_x64.msi)

4. Then set default version to wsl2:  
Powershell:
```
wsl --set-default-version 2
```

## Setting up Linux distribution

1. **Install linux distribution from windows store** (example Ubuntu)
2. **start distribution**
3. **Install latest updates**  
Linux shell:
```
apt update 
apt dist-upgrade
```

## Install Docker Desktop

1. **Download Docker Desktop** [here](https://hub.docker.com/editions/community/docker-ce-desktop-windows/)
2. **Enable wsl2 integation in Docker: Settings/Resources/wsl integration**

# Docker installation on Arch based disributions:

1. **Install the docker package:**
```
pacman -S docker
```
2. **Start the docker service:**
```
systemctl start docker.service
 
systemctl enable docker.service
```
3. **Verify the installation:**
```
docker info
```
4. **(optional) add user to docker group to run docker without ```sudo```**
```
groupadd docker
 
gpasswd -a user docker [replace user with your username]

```

# Docker installation on Ubuntu:
[Full instruction on installing docker on ubuntu](https://docs.docker.com/engine/install/ubuntu/)

1. **update apt index and install packages for installation**
```
sudo apt-get update

sudo apt-get install \
    apt-transport-https \
    ca-certificates \
    curl \
    gnupg \
    lsb-release
```

2. **Add docker gpg-key**
```
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
```

3. **Setting up stable repo for docker**
```
echo \
  "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
```

4. **Update apt index and install docker**

```
apt-get update
sudo apt-get install docker-ce docker-ce-cli containerd.io
```

5. **(optional) Verify that docker is working**
```
sudo docker run hello-world
```

# Setting up mu3e docker container
1. **Check that everything is set up correctly**  
Linux shell:
```
docker --version
Docker version 20.10.8, build *******
```

2. **Pull Docker image**   
Linux shell:
```
docker pull 4ndr85/mu3e:v2
```   

If permission is denied try:

```
sudo docker pull 4ndr85/mu3e:v2
```

3. **Run Docker  Image**   
Linux shell:
```
sudo docker run -it 4ndr85/mu3e:v2 bash
```   
Inside the container, first thing to do is to set the environment:
```
source initialize.sh
```   
To exit the container type:
```
exit
```

4. **Copying files between local system and container**   
To copy files between yout local system and the Docker container type:
```
docker cp containerID:path/to/file/to/copy/inside/container path/local/machine/where/to/copy
``` 
For instance, ```docker cp e442:/mu3e/tests/data/mu3e_run_000042.root``` will copy the file mu3e_run_000042.root from the data folder inside the container e442 (your container ID might be different) to the current directory on your local machine. To transfer file from the host machine to the container the order of the two paths, in the previous example, must be swapped. 
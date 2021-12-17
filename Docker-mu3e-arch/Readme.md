# Dockerfile for the mu3e Simulation

# Batch only modus
```
sudo docker run -it --name mu3e-docker mwjk03/mu3e:beta
```

# GUI (Linux)
~~
sudo docker run --net=host --env="DISPLAY=:0.0" --user $(id -u):$(id -g) --volume="$HOME/docker_home/:$HOME" --volume="/etc/group:/etc/group:ro" --volume="/etc/passwd:/etc/passwd:ro" --volume="/etc/shadow:/etc/shadow:ro" --volume="$HOME/.Xauthority:$HOME/.Xauthority:rw" -it --device=/dev/dri --name mu3e-docker mwjk03/mu3e:latest
~~
## Creating the container: 
- check environment variable
```
set | grep "DISPLAY"
```
__If ```DISPLAY=:``` is not 0 or 0.0 change it in the next command!__

- start the docker container
you can add a volume to this command (see below "Copy data between host and container")
```
sudo docker run --net=host --env="DISPLAY=:0.0" --volume=/tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri -it --name mu3e-docker mwjk03/mu3e:latest
touch /root/.Xauthority
```
- get XServer Cookie
on your host machine type ```xauth list ``` and copy one line. \
in your docker container type ```xauth add YOURLINE```. __You need to add a 0 (or the number after your DISPLAY variable) after the `:`in the line.__

- (optional) type ```glxgears```to test the Connection to your Display

## after a reboot of the host machine

on your host machine type ```xauth list ``` and copy one line. \
in your docker container type ```xauth add YOURLINE```. __You need to add a 0 (or the number after your DISPLAY variable) after the `:`in the line.__

# GUI (wsl with VcXsrv (Xming))
## setting up your wsl distro 
- add new graphics-drivers (for opengl support)
```
sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt-get update
sudo apt dist-upgrade
```
- Reboot wsl 
```
wsl --shutdown
```

## Creating the container: 
- check environment variable (host)
```
set | grep "DISPLAY" (copy output)
```
- start the docker container
you can add a volume to this command (see below "Copy data between host and container") \
__replace ```<output( bsp 127.0.0.1:0.0 )> ```with your copied output__
```
sudo docker run --net=host --env="DISPLAY=<output( bsp 127.0.0.1:0.0 )>" --volume=/tmp/.X11-unix:/tmp/.X11-unix --device=/dev/vfio -it --name mu3e-docker mwjk03/mu3e:latest
```

## after a reboot of the host machine
- check environment variable (host)
```
set | grep "DISPLAY" (copy output)
```
- export variable to docker (in docker container)
```
export <YOUROUTPUT>
```

# Copy data between host and container
- Attach a volume to your docker container at creation:
```
docker run ...... --volume="$HOME/docker_data/:/home/user/shared_data" .....
```
- Copy files with ```docker cp``` 

# First steps in container

```
cd /usr/bin
source geant4.sh
```

```
cd /home/user/run
mkdir data
source ../mu3e_installation/activate.sh
```
# Root password
admin

# Nonroot user
pkgbuilder (no password)
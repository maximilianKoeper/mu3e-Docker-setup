# Dockerfile for mu3e simulation

# Includes:
- ROOT
- Git
- CMake
- Boost
- Eigen3
- Geant4


# GUI (Linux)
~~
sudo docker run --net=host --env="DISPLAY=:0.0" --user $(id -u):$(id -g) --volume="$HOME/docker_home/:$HOME" --volume="/etc/group:/etc/group:ro" --volume="/etc/passwd:/etc/passwd:ro" --volume="/etc/shadow:/etc/shadow:ro" --volume="$HOME/.Xauthority:$HOME/.Xauthority:rw" -it --device=/dev/dri --name geant4-arch mwjk03/geant4-arch:beta
~~
### or
```
sudo docker run --net=host --env="DISPLAY=:0.0" --volume=/tmp/.X11-unix:/tmp/.X11-unix --device=/dev/dri -it --name geant4-arch-2 mwjk03/geant4-arch:latest

touch /root/.Xauthority
```
on your host machine type ```xauth list ``` and copy one line

in your docker container type ```xauth add YOURLINE``` You may need to add a 0 after the `:`in the line.
### after a reboot of the host machine

on your host machine type ```xauth list ``` and copy one line

in your docker container type ```xauth add YOURLINE``` You may need to add a 0 after the `:`in the line.


# GUI (wsl with VcVsrv)
```
sudo add-apt-repository ppa:oibaf/graphics-drivers
sudo apt-get update
suod apt dist-upgrade

(reboot)

set | grep "DISPLAY" (copy output)

sudo docker run --net=host --env="DISPLAY=<output( bsp 127.0.0.1:0.0 )>" --volume=/tmp/.X11-unix:/tmp/.X11-unix --device=/dev/vfio -it --name geant4-arch-2 mwjk03/geant4-arch:latest
```

# First steps in container

```
cd /usr/bin
source geant4.sh

```

# How to run an example:
(GUI mode)
```
cd /usr/share/Geant4-10.7.2/examples/basic/B1
mkdir b1_build
cd b1_build
cmake -DGeant4_DIR=/usr/lib64/Geant4-10.7.2/ ../
make -j 2 B1
./exampleB1
```
(Batch mode)
```
cd /usr/share/Geant4-10.7.2/examples/basic/B1
mkdir b1_build
cd b1_build
cmake -DGeant4_DIR=/usr/lib64/Geant4-10.7.2/ ../
make -j 2 B1
./exampleB1 run1.mac
```
## ROOT
```
root
new TBrowser()
```

# Root password
admin

# Nonroot user
pkgbuilder (no password)
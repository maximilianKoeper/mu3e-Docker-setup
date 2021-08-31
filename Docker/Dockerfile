FROM archlinux:latest

# setting up arch distro
RUN pacman -Syu --noconfirm

# downloading packages for mu3e
RUN pacman -S --noconfirm git cmake eigen boost gcc root fakeroot sudo make go nano vim

#RUN git clone https://gitlab.cern.ch/geant4/geant4.git && cd /geant4 && mkdir geant4-build && cd geant4-build && cmake -DCMAKE_INSTALL_PREFIX=/geant4-install -DGEANT4_INSTALL_DATA=ON .. && make -j15 && make install && source /geant4-install/bin/geant4.sh \ && cd / && rm -rf /geant4/geant4-build/* && rm -rf /geant4/* && rm -rf /geant4/geant4-build/ && rm -rf /geant4/

ARG user=pkgbuilder
RUN useradd -m -r -s /bin/bash $user \
  && echo "$user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$user \
  && passwd -d $user

# Install yay
RUN git clone https://aur.archlinux.org/yay.git
RUN sudo chmod 777 /yay/

USER $user
RUN cd yay \
  && makepkg -sri --needed --noconfirm \
  && cd \
  # Clean up
  && rm -rf .cache yay

RUN yay -S geant4 --noconfirm

USER root

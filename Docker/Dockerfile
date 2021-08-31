FROM archlinux:latest

# setting up arch distro
RUN pacman -Syu --noconfirm

# downloading packages for mu3e
RUN pacman -S --noconfirm git cmake eigen boost gcc root fakeroot sudo make go nano vim

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

FROM archlinux:latest

# setting up arch distro
RUN echo 'root:admin' | chpasswd \
  && touch /root/.Xauthority \
  && pacman -Syyu --noconfirm \
  && pacman -S --noconfirm git cmake gcc root fakeroot sudo make go nano vim xorg-xauth mesa-demos jupyterlab python-matplotlib python-numpy python-pandas

ARG user=user
RUN useradd -m -r -s /bin/bash $user \
  && echo "$user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$user \
  && passwd -d $user

# Install yay
RUN git clone https://aur.archlinux.org/yay.git \
  && sudo chmod 777 /yay/

USER $user
RUN cd yay \
  && makepkg -sri --needed --noconfirm \
  && cd \
  && rm -rf .cache yay
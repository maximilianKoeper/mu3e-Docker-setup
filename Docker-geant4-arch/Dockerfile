FROM archlinux:latest

RUN echo 'root:admin' | chpasswd \
  && touch /root/.Xauthority

# setting up arch distro
RUN pacman -Syyu --noconfirm \
  && pacman -S --noconfirm git \
                           base-devel \
                           cmake \
                           eigen \
                           boost \
                           gcc \
                           root \
                           fakeroot \
                           sudo \
                           make \
                           nano \
                           vim \
                           subversion \
                           gcc-fortran \
                           xorg-xauth \
                           mesa-demos \
                           pkg-config \
                           gtkmm3 \
  && yes|pacman -Scc


ARG user=pkgbuilder
RUN useradd -m -r -s /bin/bash $user \
  && echo "$user ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/$user \
  && passwd -d $user

# Install yay
RUN git clone https://aur.archlinux.org/yay-bin.git \
  && sudo chmod 777 /yay-bin/

USER $user

RUN cd /yay-bin/ \
    && makepkg -si --needed --noconfirm \
    && yay \
    && yay -S geant4 --noconfirm \
    && yay -S --noconfirm geant4-abladata \
                        bxdecay0-geant4-git \
                        geant4-incldata \
                        geant4-ensdfstatedata \
                        geant4-ledata \
                        geant4-levelgammadata \
                        geant4-neutronhpdata \
                        geant4-particlexsdata \
                        geant4-piidata \
                        geant4-radioactivedata \
                        geant4-realsurfacedata \
                        geant4-saiddata \
    && yes|yay -Scc

ENV G4ENSDFSTATEDATA=/usr/share/geant4-ensdfstatedata/G4ENSDFSTATE2.3 \
    G4LEVELGAMMADATA=/usr/share/geant4-levelgammadata/PhotonEvaporation5.7 \
    G4LEDATA=/usr/share/geant4-ledata/G4EMLOW7.13 \
    G4PARTICLEXSDATA=/usr/share/geant4-particlexsdata/G4PARTICLEXS3.1 \
    G4ABLADATA=/usr/share/geant4-abladata/G4ABLA3.1 \
    G4INCLDATA=/usr/share/geant4-incldata/G4INCL1.0 \
    G4NEUTRONHPDATA=/usr/share/geant4-neutronhpdata/G4NDL4.6 \
    G4PIIDATA=/usr/share/geant4-piidata/G4PII1.3 \
    G4RADIOACTIVEDATA=/usr/share/geant4-radioactivedata/RadioactiveDecay5.4 \
    G4REALSURFACEDATA=/usr/share/geant4-realsurfacedata/RealSurface2.2 \
    G4SAIDXSDATA=/usr/share/geant4-saiddata/G4SAIDDATA2.0 \
    QT_X11_NO_MITSHM=1

USER root

FROM mwjk03/geant4-arch:latest

# RUN echo 'root:admin' | chpasswd

# RUN pacman -S --noconfirm xorg-xauth mesa-demos

ADD mu3e /home/user/mu3e

RUN chmod 777 /home/user/mu3e

RUN cd /home/user/mu3e \
    && mkdir build \
    && cd build \
    && cmake -DCMAKE_INSTALL_PREFIX=/home/user/mu3e_installation -DMU3E_DISPLAY=ON .. \
    && make -j8 \
    && make install \
    && cd ../.. \
    && cp mu3e/run run -r \
    && rm -rf mu3e

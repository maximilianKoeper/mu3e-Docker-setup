FROM ubuntu:bionic as builder
MAINTAINER Maximilian Köper <maximilian.koeper@kip.uni-heidelberg.de>

ENV G4_VERSION v10.7.0

RUN apt-get update -y && \
    apt-get install -y cmake curl g++ libexpat1-dev tar qt4-default
COPY geant4.10.07.p03.tar.gz /
RUN mkdir -p /opt/geant4/src && \
    mkdir -p /opt/geant4/build && \
    mkdir -p /opt/geant4/install && \
    mkdir -p /opt/geant4/data && \
    tar xf /geant4.10.07.p03.tar.gz -C /opt/geant4/src && \
    cd /opt/geant4/build && \
    cmake -DCMAKE_INSTALL_PREFIX=/opt/geant4/install \
          -DGEANT4_INSTALL_DATA=ON \
          -DGEANT4_INSTALL_DATADIR=/opt/geant4/data \
          -DGEANT4_BUILD_MULTITHREADED=ON \
          -DGEANT4_INSTALL_EXAMPLES=OFF \
          -DGEANT4_USE_QT=ON \
          ../src/geant4.10.07.p03 && \
    make -j`nproc` && \
    make install


FROM ubuntu:bionic

RUN apt-get update -y && \
    apt-get install -y cmake g++ libexpat1-dev && \
    apt-get autoremove -y
    #apt-get clean -y && \
    #rm -rf /var/cache/apt/archives/* && \
    #rm -rf /var/lib/apt/lists/*

RUN apt-get install -y  dpkg-dev cmake g++ gcc binutils libx11-dev libxpm-dev \
                        libxft-dev libxext-dev python libssl-dev git

RUN apt-get install -y uuid-dev subversion libeigen3-dev gfortran libboost-all-dev

RUN git clone --branch latest-stable https://github.com/root-project/root.git root_src
RUN mkdir root_build root_install && cd root_build \
    && cmake -DCMAKE_INSTALL_PREFIX=../root_install -DCMAKE_CXX_STANDARD=17 ../root_src \
    && cmake --build . -- install -j4

#RUN source ../root_install/bin/thisroot.sh


RUN mkdir -p /opt/geant4/data
COPY --from=builder /opt/geant4/install /opt/geant4/install
#COPY entry-point.sh /entry-point.sh

#WORKDIR /root

#ENTRYPOINT ["/entry-point.sh"]
CMD ["/bin/bash"]

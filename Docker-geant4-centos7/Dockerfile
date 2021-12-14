FROM centos:centos7
MAINTAINER Maximilian Köper <maximilian.koeper@kip.uni-heidelberg.de>

RUN echo 'root:admin' | chpasswd

RUN yum update -y \
    && yum -y install centos-release-scl \
                      devtoolset-9 \
                      nano vim \
                      epel-release \
                      root \
                      git \
                      cmake3 \
                      gcc-fortran \
                      eigen3-devel \
                      make \
                      expat-devel \
                      xerces-c-devel \
                      subversion \
                      wget \
                      python-devel \
                      binutils \
                      libX11-devel \
                      libXpm-devel \
                      libXft-devel \
                      libXext-devel \
                      python \
                      openssl-devel \

    && yum clean all


RUN source scl_source enable devtoolset-9 \
    && wget https://boostorg.jfrog.io/artifactory/main/release/1.78.0/source/boost_1_78_0.tar.gz \
    && tar zxvf boost_1_78_0.tar.gz \
    && cd boost_1_78_0/ \
    && ./bootstrap.sh --prefix=/usr/local/include/boost \
    && ./b2 install --prefix=/usr/local/include/boost --with=all

ENV BOOST_ROOT=/usr/local/include/boost

RUN source scl_source enable devtoolset-9 \
    && git clone --branch latest-stable https://github.com/root-project/root.git root_src \
    && mkdir root_build root_install && cd root_build \
    && cmake3 -DCMAKE_INSTALL_PREFIX=/root_install ../root_src \
    && cmake3 --build . -- install -j7

RUN source scl_source enable devtoolset-9 \
    && git clone https://gitlab.cern.ch/geant4/geant4.git \
    && cd /geant4 \
    && mkdir geant4-build \
    && cd geant4-build \
    && cmake3 -DCMAKE_INSTALL_PREFIX=/geant4-install \
              -DGEANT4_INSTALL_DATA=ON \
              -DGEANT4_BUILD_MULTITHREADED=ON \
              -DGEANT4_USE_GDML=ON \
              -DCMAKE_C_COMPILER=/opt/rh/devtoolset-9/root/usr/bin/gcc \
              -DCMAKE_CXX_COMPILER=/opt/rh/devtoolset-9/root/usr/bin/g++ \
             .. \
    && make -j8 \
    && make install \
    && source /geant4-install/bin/geant4.sh \
    && cd / \
    && rm -rf /geant4/geant4-build/* \
    && rm -rf /geant4/* \
    && rm -rf /geant4/geant4-build/ \
    && rm -rf /geant4/



#ADD mu3e /mu3e
#RUN source root_install/bin/thisroot.sh \
#    && cd /mu3e \
#    && git checkout master \
#    && mkdir build \
#    && cd build \
#    && cmake3 -DCMAKE_C_COMPILER=/opt/rh/devtoolset-9/root/usr/bin/gcc \
#              -DCMAKE_CXX_COMPILER=/opt/rh/devtoolset-9/root/usr/bin/g++ \
#             .. \
#    && make -j8 \
#    && make install \
#    && cd ../run/ \
#    && mkdir data


CMD ["/usr/bin/bash"]

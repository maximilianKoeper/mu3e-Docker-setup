FROM mwjk03/geant4-centos7:latest
MAINTAINER Maximilian Köper <maximilian.koeper@kip.uni-heidelberg.de>

ARG NUMBER_CORES=7
COPY mu3e/ /mu3e/

RUN source /setup.sh \
    && cd /mu3e \
    && git checkout master \
    && mkdir build \
    && cd build \
    && cmake3 .. \
    && make -j${NUMBER_CORES} \
    && make install \
    && cd ../run/ \
    && mkdir data


COPY setup.sh /etc/profile.d/setup_mu3e.sh
RUN chmod +x /etc/profile.d/setup_mu3e.sh

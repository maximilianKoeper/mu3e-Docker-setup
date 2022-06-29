#!/bin/bash
echo "Setting up Environment Variables"

LD_LIBRARY_PATH="$LD_LIBRARY_PATH:/usr/local/include/boost/lib/"
source /geant4-install/bin/geant4.sh
source /root_install/bin/thisroot.sh
source /opt/rh/devtoolset-9/enable
source /mu3e/install/activate.sh

ldconfig
echo "Environment is ready to use"

/bin/bash

##########################################################
## Script that sets up the basic layers and poky directory
##########################################################

BASE_DIR=${PWD}
POKY_DIR=${PWD}/.rk3288-linux
MIRROR_DIR=${PWD}/layers

if [ ! -d "${POKY_DIR}" ];
then
    mkdir -p ${POKY_DIR} && cd ${POKY_DIR}
else
    if [ ! -d "${POKY_DIR}/poky" ];
    then
        git clone -b dunfell git://git.yoctoproject.org/poky
    fi
fi

cd ${BASE_DIR}

cd ${MIRROR_DIR}
# Check if meta-rockchip exists in the MIRROR_DIR
if [ ! -d "${MIRROR_DIR}/meta-rockchip" ];
then
	git clone -b dunfell git://git.yoctoproject.org/meta-rockchip
fi


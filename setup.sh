##########################################################
## Script that sets up the basic layers and poky directory
##########################################################

BASE_DIR=${PWD}
MIRROR_DIR=${PWD}/.build-linux

if [ ! -d "${MIRROR_DIR}" ];
then
    mkdir -p ${MIRROR_DIR}
fi

cd ${MIRROR_DIR}
if [ ! -d "poky" ];
  then
      git clone -b dunfell git://git.yoctoproject.org/poky
fi

# Check if meta-rockchip exists in the MIRROR_DIR
if [ ! -d "meta-rockchip" ];
then
	git clone -b dunfell git://git.yoctoproject.org/meta-rockchip
fi


# Check if meta-oe exists in the MIRROR_DIR
if [ ! -d "meta-oe" ];
then
        git clone -b dunfell git://git.openembedded.org/meta-openembedded
fi




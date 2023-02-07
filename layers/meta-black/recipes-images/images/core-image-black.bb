inherit core-image


AUTHOR = "Rene @Biamp Systems"
DESCRIPTION = "BBB core image recipe"
SUMMARY = "core-image-black"

BASE_INSTALLATION_PACKAGE_GROUP = " \
		packagegroup-core-boot \
		"


IMAGE_INSTALL = " ${BASE_INSTALLATION_PACKAGE_GROUP}"

IMAGE_INSTALL_append = " sample-driver"

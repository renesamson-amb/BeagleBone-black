inherit core-image


require core-image-hack-rk3288.inc



AUTHOR = "Rene @Biamp Systems"
DESCRIPTION = "ROCKChip Rk3288 core image recipe"
SUMMARY = "core-image-rk3288"

BASE_INSTALLATION_PACKAGE_GROUP = " \
		packagegroup-core-boot \
		"

IMAGE_INSTALL ?= "${BASE_INSTALLATION_PACKAGE_GROUP}"

IMAGE_INSTALL_append = "${HACK_LINUX_CORE_PACKAGES}"



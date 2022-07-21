FILESEXTRAPATHS_prepend := "${THISDIR}/files:"

#   file://hack-rk3288.dts


SRC_URI += " \
   file://hack-rk3288.dts \
   file://devtool-fragment.cfg \
"

#unset KBUILD_DEFCONFIG
#KERNEL_DEFCONFIG_starburst-rk3399 = "${WORKDIR}/hack_defconfig"

#do_configure_append () {
#   cp ${WORKDIR}/rk3399-starburst.dts ${S}/arch/arm64/boot/dts/rockchip/rk3399-starburst.dts

# merge in our fragments to the .config
# See this answer for reference: https://stackoverflow.com/a/4658571
#   ${S}/scripts/kconfig/merge_config.sh -m -O ${B} ${B}/.config ${WORKDIR}/*.cfg
#}

COMPATIBLE_MACHINE .= "|hack-rk3288"





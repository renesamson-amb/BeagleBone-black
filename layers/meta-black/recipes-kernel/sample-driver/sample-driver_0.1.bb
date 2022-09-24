# Recipe for building sample driver
SUMMARY = "Build the sample driver"
LICENSE = "GPLv2"
LIC_FILES_CHKSUM = "file://COPYING;md5=0417808f7c7e5d1466953b9a9cb33c18"

inherit module

SRC_URI = "file://Makefile \
	   file://COPYING \
	   file://sample-driver.c \
	  "

S = "${WORKDIR}"

RPROVIDES_${PN} += "kernel-module-sample-driver"


LICENSE = "R3"

inherit core-image
inherit extrausers
#inherit python3

EXTRA_USER_PARAMS = " \
	usermod -d '/root' -m root; \
	groupadd hackz; \
	useradd -d '/home/hackz' -M hackz;  \
	usermod -p '' hackz; \
	usermod -a -G hackz,sudo hackz; \
"


HACK_LINUX_CORE_PACKAGES = " \
	alsa-lib \
	alsa-utils \
	kmod \
	libdaemon \
	libsegfault \
	libstdc++ \
	libdrm \
	libdrm-tests \
	lighttpd \
	kernel-modules \
	kernel-module-arp* \
	kernel-module-ip* \
	kernel-module-nf-* \
	kernel-module-nfnetlink* \
	kernel-module-x-tables \
	kernel-module-xt-* \
	python3 \
	python3-protobuf \
	tcpdump \
	systemd \
	htop \
	zip \
"
	


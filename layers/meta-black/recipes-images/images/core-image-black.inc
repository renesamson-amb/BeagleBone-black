LICENSE = "R3"

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
	kmod \
	kernel-modules \
	python3 \
"
	

BLACK_DRIVER_PACKAGES = " \
	sample-driver \
"

